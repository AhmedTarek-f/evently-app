import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/choose_event_location/presentation/views/choose_event_location_view.dart';
import 'package:evently_app/features/choose_event_location/presentation/views_model/choose_event_location_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<StartCubit>(context);
    final createEventController = BlocProvider.of<CreateEventCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.location.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const RSizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryFixed,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(
              16.r,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<ChooseEventLocationCubit>(
                        create: (context) => ChooseEventLocationCubit(context),
                      ),
                      BlocProvider.value(
                        value: createEventController,
                      ),
                    ],
                    child: const ChooseEventLocationView(),
                  ),
                ),
              );
            },
            child: RPadding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 46.r,
                    height: 46.r,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.location,
                      width: 22.r,
                      height: 22.r,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primaryFixed,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const RSizedBox(width: 8),
                  Expanded(
                    child: BlocBuilder<CreateEventCubit, CreateEventState>(
                      buildWhen: (previous, current) =>
                          current is SelectEventLocationLoadingState ||
                          current is SelectEventLocationSuccessState,
                      builder: (context, state) =>
                          state is SelectEventLocationLoadingState
                              ? ShimmerEffect(
                                  width: ScreenUtil().screenWidth,
                                  height: 16.h,
                                )
                              : Text(
                                  createEventController.locationLat == null
                                      ? AppText.chooseEventLocation.tr()
                                      : "${createEventController.country} , ${createEventController.city}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                    ),
                  ),
                  const RSizedBox(width: 8),
                  Icon(
                    startController.isArLanguage
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
