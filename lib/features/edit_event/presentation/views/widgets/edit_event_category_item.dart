import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/features/create_event/data/models/category_item_model.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditEventCategoryItem extends StatelessWidget {
  const EditEventCategoryItem({
    super.key,
    required this.categoryDetails,
    this.isSelected = false,
  });
  final CategoryItemModel categoryDetails;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final editEventController = BlocProvider.of<EditEventCubit>(context);
    return GestureDetector(
      onTap: () => editEventController.changeSelectedCategory(
        categoryItem: categoryDetails,
      ),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            37.r,
          ),
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        duration: const Duration(milliseconds: 300),
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                categoryDetails.categoryIcon,
                width: 24.r,
                height: 24.r,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? Theme.of(context).colorScheme.primaryFixed
                      : Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              const RSizedBox(width: 8),
              Text(
                categoryDetails.categoryName.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryFixed
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
