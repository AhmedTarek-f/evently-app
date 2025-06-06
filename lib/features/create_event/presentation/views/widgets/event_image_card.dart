import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventImageCard extends StatelessWidget {
  const EventImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<CreateEventCubit>(context);
    return BlocBuilder<CreateEventCubit, CreateEventState>(
      buildWhen: (previous, current) => current is ChangeSelectedCategoryState,
      builder: (context, state) => ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.asset(
          EventlyMethodsHelper.getEventCategoryImage(
            eventCategory: controller.selectedCategoryItem.categoryName,
            context: context,
          ),
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (frame == null) {
              return const EventImageCardShimmer();
            }
            return child;
          },
        ),
      ),
    );
  }
}
