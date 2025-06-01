import 'package:evently_app/core/common_widgets/shimmer/event_image_card_shimmer.dart';
import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditEventImageCard extends StatelessWidget {
  const EditEventImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditEventCubit>(context);
    return BlocBuilder<EditEventCubit, EditEventState>(
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
