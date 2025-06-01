import 'dart:math';

import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/event_details/data/repositories/event_details_repository.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  EventDetailsCubit(
      BuildContext context, EventModel eventDetails, UserModel userData)
      : _context = context,
        eventData = eventDetails,
        _currentUserData = userData,
        super(EventDetailsInitial()) {
    onInit();
  }

  final BuildContext _context;
  final EventModel eventData;
  final UserModel _currentUserData;
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  late BitmapDescriptor customIcon;
  String? nightMapStyle;
  Set<Marker> markers = {};
  UserModel eventCreatorData = UserModel.empty();
  List<UserModel> participatingMembersData = [];
  bool isJoinedIn = false;

  String getFormatedDate({required DateTime? date}) {
    return DateFormat('d MMMM y').format(date ?? DateTime.now());
  }

  String getFormatedTime({required DateTime? time}) {
    return DateFormat('h:mma').format(time ?? DateTime.now());
  }

  void onInit() async {
    initialCameraPosition = const CameraPosition(
      target: LatLng(29.973807, 31.275680),
      zoom: 11,
    );
    if (BlocProvider.of<StartCubit>(_context).isDarkMode) await initMapStyle();
    await loadCustomIcon();
    checkIfUserJoinedTheEvent();
    await fetchEventCreatorData();
    await fetchParticipateUsersData();
  }

  Future<void> loadCustomIcon() async {
    customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(),
      AppImages.mapMarker,
      width: 34.r,
      height: 34.r,
    );
    emit(CustomIconLoadState());
  }

  Future<void> initMapStyle() async {
    nightMapStyle =
        await rootBundle.loadString("assets/map_styles/night_map_style.json");
    emit(MapStyleLoadState());
  }

  Future<void> animateCameraToEventLocation({
    required EventModel eventData,
  }) async {
    final LatLng newPosition = LatLng(
      double.parse(eventData.eventLocationLat ?? "0"),
      double.parse(eventData.eventLocationLang ?? "0"),
    );
    CameraPosition cameraPosition =
        CameraPosition(target: newPosition, zoom: 15);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    markers.add(
      Marker(
        markerId: MarkerId("event_marker${eventData.eventId}"),
        icon: customIcon,
        position: newPosition,
        infoWindow: InfoWindow(title: eventData.eventTitle),
      ),
    );
  }

  Future<void> fetchEventCreatorData() async {
    emit(FetchEventCreatorLoadingState());
    var eventCreatorDataResult = await EventDetailsRepository.fetchEventCreator(
      userId: eventData.eventCreatorId ?? "",
    );
    eventCreatorDataResult.fold(
      (failure) => emit(FetchEventCreatorFailureState(
        errorMessage: failure.errorMessage,
      )),
      (eventCreator) {
        eventCreatorData = eventCreator;
        emit(FetchEventCreatorSuccessState());
      },
    );
  }

  Future<void> fetchParticipateUsersData() async {
    emit(FetchParticipateUsersLoadingState());
    var participateUsersDataResult =
        await EventDetailsRepository.fetchParticipateUsers(
      participateUserIds: _getRandomUserSubset(
        list: eventData.participateUsers ?? [],
        count: 10,
      ),
    );
    participateUsersDataResult.fold(
      (failure) => emit(FetchParticipateUsersFailureState(
        errorMessage: failure.errorMessage,
      )),
      (participatingMembers) {
        participatingMembersData = participatingMembers;
        emit(FetchParticipateUsersSuccessState());
      },
    );
  }

  List<String> _getRandomUserSubset(
      {required List<String> list, required int count}) {
    if (count >= list.length) {
      return List.from(list);
    }

    List<String> copy = List.from(list);
    copy.shuffle(Random());
    return copy.sublist(0, count);
  }

  void checkIfUserJoinedTheEvent() {
    isJoinedIn = eventData.participateUsers
            ?.contains(FirebaseAuth.instance.currentUser?.uid) ??
        false;
    emit(GetUserJoiningState());
  }

  Future<void> toggleJoinTheEvent() async {
    List<String> copyOfParticipateUsers = [];
    copyOfParticipateUsers.addAll(eventData.participateUsers!);
    emit(ToggleParticipateInOutEventLoadingState());
    if (isJoinedIn) {
      copyOfParticipateUsers.removeWhere(
          (userId) => userId == FirebaseAuth.instance.currentUser?.uid);
    } else {
      copyOfParticipateUsers.add(FirebaseAuth.instance.currentUser!.uid);
    }
    final result = await EventDetailsRepository.participateInEvent(
      eventId: eventData.eventId ?? "",
      participateUserIds: copyOfParticipateUsers,
    );
    result.fold(
      (failure) => emit(
        ToggleParticipateInOutEventFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (success) {
        if (isJoinedIn) {
          eventData.participateUsers?.removeWhere(
              (userId) => userId == FirebaseAuth.instance.currentUser?.uid);
          participatingMembersData.removeWhere(
              (user) => user.id == FirebaseAuth.instance.currentUser?.uid);
          isJoinedIn = !isJoinedIn;
          emit(ChangeParticipateUsersState());
        } else {
          eventData.participateUsers
              ?.add(FirebaseAuth.instance.currentUser!.uid);
          participatingMembersData.add(_currentUserData);
          isJoinedIn = !isJoinedIn;
          emit(ChangeParticipateUsersState());
        }
        emit(
          ToggleParticipateInOutEventSuccessState(),
        );
      },
    );
  }

  @override
  Future<void> close() {
    googleMapController?.dispose();
    return super.close();
  }
}
