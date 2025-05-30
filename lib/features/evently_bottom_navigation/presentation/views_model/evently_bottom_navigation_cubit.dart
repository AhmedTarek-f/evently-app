import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_state.dart';
import 'package:evently_app/features/favorite/presentation/views/favorite_view.dart';
import 'package:evently_app/features/home/presentation/views/home_view.dart';
import 'package:evently_app/features/map/presentation/views/map_view.dart';
import 'package:evently_app/features/profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventlyBottomNavigationCubit extends Cubit<EventlyBottomNavigationState> {
  EventlyBottomNavigationCubit()
      : super(const EventlyBottomNavigationInitial(tapIndex: 0));

  final List<Widget> eventlyNavigationList = const [
    HomeView(),
    MapView(),
    FavoriteView(),
    ProfileView(),
  ];

  void changeIndex({required int index}) {
    emit(ChangeTapState(tapIndex: index));
  }
}
