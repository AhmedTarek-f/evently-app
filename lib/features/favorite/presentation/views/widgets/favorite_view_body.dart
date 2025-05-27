import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_search_field.dart';
import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const RPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          RSizedBox(height: 12),
          FavoriteEventSearchField(),
          RSizedBox(height: 16),
          FavoriteEventsList(),
        ],
      ),
    );
  }
}
