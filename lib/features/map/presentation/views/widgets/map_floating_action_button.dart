import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/features/map/presentation/views_model/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapFloatingActionButton extends StatelessWidget {
  const MapFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<MapCubit>(context);
    return RPadding(
      padding: const EdgeInsets.only(top: 16),
      child: FloatingActionButton(
        onPressed: () async {
          await controller.animateCameraToMyLocation();
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
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
    );
  }
}
