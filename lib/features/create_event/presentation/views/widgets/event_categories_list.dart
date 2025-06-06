import 'package:evently_app/core/utils/evently_methods_helper.dart';
import 'package:evently_app/features/create_event/presentation/views/widgets/event_category_item.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCategoriesList extends StatelessWidget {
  const EventCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final createEventController = BlocProvider.of<CreateEventCubit>(context);
    return RSizedBox(
      height: 40.h,
      child: BlocBuilder<CreateEventCubit, CreateEventState>(
        buildWhen: (previous, current) =>
            current is ChangeSelectedCategoryState,
        builder: (context, state) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => EventCategoryItem(
            categoryDetails: EventlyMethodsHelper.eventCategoriesList[index],
            isSelected: createEventController.selectedCategoryItem ==
                EventlyMethodsHelper.eventCategoriesList[index],
          ),
          separatorBuilder: (_, __) => const RSizedBox(width: 10),
          itemCount: EventlyMethodsHelper.eventCategoriesList.length,
        ),
      ),
    );
  }
}
