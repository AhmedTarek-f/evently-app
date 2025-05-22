import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/create_event/data/models/category_item_model.dart';
import 'package:flutter/material.dart';

abstract class EventlyMethodsHelper {
  static String getEventCategoryImage({
    required String eventCategory,
    required BuildContext context,
  }) {
    final bool isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    if (isDarkMode) {
      switch (eventCategory) {
        case "sport":
          return AppImages.sportDark;
        case "birthday":
          return AppImages.birthdayDark;
        case "meeting":
          return AppImages.meetingDark;
        case "gaming":
          return AppImages.gamingDark;
        case "eating":
          return AppImages.eatingDark;
        case "holiday":
          return AppImages.holidayDark;
        case "exhibition":
          return AppImages.exhibitionDark;
        case "workShop":
          return AppImages.workShopDark;
        case "bookClub":
          return AppImages.bookClubDark;
        default:
          return AppImages.holidayDark;
      }
    } else {
      switch (eventCategory) {
        case "sport":
          return AppImages.sportLight;
        case "birthday":
          return AppImages.birthdayLight;
        case "meeting":
          return AppImages.meetingLight;
        case "gaming":
          return AppImages.gamingLight;
        case "eating":
          return AppImages.eatingLight;
        case "holiday":
          return AppImages.holidayLight;
        case "exhibition":
          return AppImages.exhibitionLight;
        case "workShop":
          return AppImages.workShopLight;
        case "bookClub":
          return AppImages.bookClubLight;
        default:
          return AppImages.holidayLight;
      }
    }
  }

  static final List<CategoryItemModel> eventCategoriesList = const [
    CategoryItemModel(
      categoryName: AppText.bookClub,
      categoryIcon: AppIcons.bookClub,
    ),
    CategoryItemModel(
      categoryName: AppText.sport,
      categoryIcon: AppIcons.sport,
    ),
    CategoryItemModel(
      categoryName: AppText.birthday,
      categoryIcon: AppIcons.birthday,
    ),
    CategoryItemModel(
      categoryName: AppText.eating,
      categoryIcon: AppIcons.eating,
    ),
    CategoryItemModel(
      categoryName: AppText.gaming,
      categoryIcon: AppIcons.gaming,
    ),
    CategoryItemModel(
      categoryName: AppText.meeting,
      categoryIcon: AppIcons.meeting,
    ),
    CategoryItemModel(
      categoryName: AppText.holiday,
      categoryIcon: AppIcons.holiday,
    ),
    CategoryItemModel(
      categoryName: AppText.workShop,
      categoryIcon: AppIcons.workShop,
    ),
    CategoryItemModel(
      categoryName: AppText.exhibition,
      categoryIcon: AppIcons.exhibition,
    ),
  ];
}
