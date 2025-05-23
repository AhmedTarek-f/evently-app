import 'package:evently_app/core/utils/services/firestore_services/firestore_services.dart';
import 'package:evently_app/features/evently_bottom_navigation/data/repositories/evently_bottom_nav_repository.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:evently_app/features/favorite/presentation/views/favorite_view.dart';
import 'package:evently_app/features/home/presentation/views/home_view.dart';
import 'package:evently_app/features/map/presentation/views/map_view.dart';
import 'package:evently_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventlyBottomNavigationCubit extends Cubit<EventlyBottomNavigationState> {
  EventlyBottomNavigationCubit() : super(EventlyBottomNavigationInitial()) {
    fetchUserData();
  }
  int currentTapIndex = 0;

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
    if (FireStoreServices.currentUserData == null) {
      emit(FetchUserDataLoadingState());
      var userDataResult = await EventlyBottomNavRepository.getUserData();
      userDataResult.fold(
        (failure) => emit(FetchUserDataFailureState(
          errorMessage: failure.errorMessage,
        )),
        (userData) {
          FireStoreServices.currentUserData = userData;
          emit(FetchUserDataSuccessState());
        },
      );
    }
  }
}
