import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_drop_down_button_form_field.dart';
import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/constants/app_colors.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/created_events/presentation/views/created_events_view.dart';
import 'package:evently_app/features/created_events/presentation/views_model/created_events_cubit.dart';
import 'package:evently_app/features/evently_bottom_navigation/presentation/views_model/evently_bottom_navigation_cubit.dart';
import 'package:evently_app/features/events_participated_in/presentation/views/events_participated_in_view.dart';
import 'package:evently_app/features/events_participated_in/presentation/views_model/events_participated_in_cubit.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileOptions extends StatelessWidget {
  const UserProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ProfileCubit>(context);
    final eventlyController =
        BlocProvider.of<EventlyBottomNavigationCubit>(context);
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<CreatedEventsCubit>(
                        create: (context) => CreatedEventsCubit(),
                      ),
                      BlocProvider<EventlyBottomNavigationCubit>.value(
                        value: eventlyController,
                      ),
                    ],
                    child: const CreatedEventsView(),
                  ),
                ),
              );
            },
            buttonTitle: "",
            isText: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppIcons.crownStar,
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.cover,
                ),
                const RSizedBox(width: 8),
                Text(
                  AppText.createdEvents.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                      ),
                )
              ],
            ),
          ),
          const RSizedBox(height: 8),
          CustomElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<EventsParticipatedInCubit>(
                        create: (context) => EventsParticipatedInCubit(),
                      ),
                      BlocProvider<EventlyBottomNavigationCubit>.value(
                        value: eventlyController,
                      ),
                    ],
                    child: const EventsParticipatedInView(),
                  ),
                ),
              );
            },
            buttonTitle: "",
            isText: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppIcons.group,
                  width: 24.r,
                  height: 24.r,
                  fit: BoxFit.cover,
                ),
                const RSizedBox(width: 8),
                Text(
                  AppText.eventsParticipatedIn.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                      ),
                )
              ],
            ),
          ),
          const RSizedBox(height: 16),
          Text(
            AppText.languageCapital.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const RSizedBox(height: 8),
          CustomDropDownButtonFormField(
            dropDownItemsList: controller.languages,
            initialValue: controller.currentLanguage,
            onChanged: (language) => controller.changeLanguage(
              context: context,
              languageValue: language,
            ),
          ),
          const RSizedBox(height: 8),
          Text(
            AppText.themeCapital.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const RSizedBox(height: 8),
          CustomDropDownButtonFormField(
            dropDownItemsList: controller.theme,
            initialValue: controller.currentTheme,
            onChanged: (theme) async => await controller.changeTheme(
              context: context,
              themeValue: theme,
            ),
          ),
        ],
      ),
    );
  }
}
