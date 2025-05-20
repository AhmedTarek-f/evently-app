import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_card_list.dart';
import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_event_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const RPadding(
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
      ),
      child: Column(
        children: [
          FavoriteEventSearchField(),
          RSizedBox(height: 16),
          Expanded(
            child: FavoriteEventCardList(),
          ),
        ],
      ),
    );
  }
}
