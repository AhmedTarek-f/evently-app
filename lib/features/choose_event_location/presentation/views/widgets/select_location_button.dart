import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/features/choose_event_location/presentation/views_model/choose_event_location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectLocationButton extends StatelessWidget {
  const SelectLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ChooseEventLocationCubit>(context);
    return GestureDetector(
      onTap: () {
        controller.isEditEvent == true
            ? controller.selectEventLocationEdit()
            : controller.selectEventLocation();
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenUtil().screenWidth,
        height: 60.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.r),
            topLeft: Radius.circular(12.r),
          ),
        ),
        child: Text(
          AppText.tapOnLocationToSelect,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
