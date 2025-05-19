import 'package:evently_app/core/cache/shared_preferences_helper.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/constants/const_keys.dart';
import 'package:evently_app/features/onboarding/data/models/onboarding_model.dart';
import 'package:evently_app/features/onboarding/presentation/views_model/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial()) {
    onInit();
  }
  final List<OnboardingModel> lightOnBoardingList = const [
    OnboardingModel(
      image: AppImages.lightOnboarding1,
      title: AppText.onBoardingTitle1,
      subTitle: AppText.onBoardingSubTitle1,
    ),
    OnboardingModel(
      image: AppImages.lightOnboarding2,
      title: AppText.onBoardingTitle2,
      subTitle: AppText.onBoardingSubTitle2,
    ),
    OnboardingModel(
      image: AppImages.lightOnboarding3,
      title: AppText.onBoardingTitle3,
      subTitle: AppText.onBoardingSubTitle3,
    ),
  ];
  final List<OnboardingModel> darkOnBoardingList = const [
    OnboardingModel(
      image: AppImages.darkOnboarding1,
      title: AppText.onBoardingTitle1,
      subTitle: AppText.onBoardingSubTitle1,
    ),
    OnboardingModel(
      image: AppImages.darkOnboarding2,
      title: AppText.onBoardingTitle2,
      subTitle: AppText.onBoardingSubTitle2,
    ),
    OnboardingModel(
      image: AppImages.darkOnboarding3,
      title: AppText.onBoardingTitle3,
      subTitle: AppText.onBoardingSubTitle3,
    ),
  ];
  late final PageController onBoardingPageController;
  int currentPageIndex = 0;

  void onInit() {
    onBoardingPageController = PageController();
  }

  void updateCurrentPageIndex({required int newIndex}) {
    currentPageIndex = newIndex;
    emit(UpdatingOnboardingPageIndex());
  }

  void navigateToDotIndexPage({required int index}) {
    onBoardingPageController.jumpToPage(index);
  }

  void moveToNextPage() {
    if (currentPageIndex == 2) {
      emit(MovingToLoginScreenState());
    } else {
      onBoardingPageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    }
  }

  void moveToPreviousPage() {
    onBoardingPageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  Future<void> finishedOnboardingFirstTime() async {
    await SharedPreferencesHelper.saveBool(
      key: ConstKeys.isHomeScreen,
      value: true,
    );
  }

  @override
  Future<void> close() {
    onBoardingPageController.dispose();
    return super.close();
  }
}
