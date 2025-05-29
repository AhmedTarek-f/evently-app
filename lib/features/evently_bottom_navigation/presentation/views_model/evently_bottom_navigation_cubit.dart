import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/evently_bottom_navigation/data/repositories/evently_bottom_nav_repository.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:evently_app/features/favorite/presentation/views/favorite_view.dart';
import 'package:evently_app/features/home/presentation/views/home_view.dart';
import 'package:evently_app/features/map/presentation/views/map_view.dart';
import 'package:evently_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EventlyBottomNavigationCubit extends Cubit<EventlyBottomNavigationState> {
  EventlyBottomNavigationCubit() : super(EventlyBottomNavigationInitial()) {
    onInit();
  }
  int currentTapIndex = 0;
  UserModel? currentUserData;
  LocationData? userLocation;
  String? userCountry;
  String? userCity;

  void onInit() {
    fetchUserData();
  }

  final List<Widget> eventlyNavigationList = const [
    HomeView(),
    MapView(),
    FavoriteView(),
    ProfileView(),
  ];

  void changeIndex({required int index}) {
    if (currentTapIndex != index) {
      currentTapIndex = index;
      emit(ChangeTapState());
    }
  }

  Future<void> fetchUserData() async {
    emit(FetchUserDataLoadingState());
    await getUserLocation();
    await fetchUserLocation();
    var userDataResult = await EventlyBottomNavRepository.getUserData();
    userDataResult.fold(
      (failure) => emit(FetchUserDataFailureState(
        errorMessage: failure.errorMessage,
      )),
      (userData) {
        currentUserData = userData;
        emit(FetchUserDataSuccessState());
      },
    );
  }

  Future<void> getUserLocation() async {
    var result = await EventlyBottomNavRepository.getLocation();
    result.fold(
      (failure) => emit(
        GetLocationDataFailureState(
          errorMessage: failure.errorMessage,
        ),
      ),
      (locationData) => userLocation = locationData,
    );
  }

  Future<void> fetchUserLocation() async {
    if (userLocation != null) {
      emit(FetchUserLocationLoadingState());
      var result = await EventlyBottomNavRepository.fetchUserLocationName(
        eventLocation: LatLng(
          userLocation!.latitude!,
          userLocation!.longitude!,
        ),
      );
      result.fold(
        (failure) => emit(
          FetchUserLocationFailureState(
            errorMessage: failure.errorMessage,
          ),
        ),
        (locationName) {
          userCountry = locationName.first.country;
          userCity = locationName.first.locality;
          emit(FetchUserLocationSuccessState());
        },
      );
    }
  }
}
