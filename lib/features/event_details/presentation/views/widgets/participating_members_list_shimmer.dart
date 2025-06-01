import 'package:evently_app/core/common_widgets/shimmer/display_user_details_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipatingMembersListShimmer extends StatelessWidget {
  const ParticipatingMembersListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return RSizedBox(
      height: 74,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, __) => const DisplayUserDetailsShimmer(),
        separatorBuilder: (_, __) => const RSizedBox(width: 8),
        itemCount: 10,
      ),
    );
  }
}
