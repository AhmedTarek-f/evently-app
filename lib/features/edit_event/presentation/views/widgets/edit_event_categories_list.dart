import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/edit_event/presentation/views/widgets/edit_event_category_item.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditEventCategoriesList extends StatelessWidget {
  const EditEventCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final editEventController = BlocProvider.of<EditEventCubit>(context);
    return RSizedBox(
      height: 40.h,
      child: BlocBuilder<EditEventCubit, EditEventState>(
        buildWhen: (previous, current) =>
            current is ChangeSelectedCategoryState,
        builder: (context, state) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => EditEventCategoryItem(
            categoryDetails: EventlyMethodsHelper.eventCategoriesList[index],
            isSelected: editEventController.selectedCategoryItem ==
                EventlyMethodsHelper.eventCategoriesList[index],
          ),
          separatorBuilder: (_, __) => const RSizedBox(width: 10),
          itemCount: EventlyMethodsHelper.eventCategoriesList.length,
        ),
      ),
    );
  }
}
