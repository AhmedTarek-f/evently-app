import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/map/presentation/views/widgets/events_horizontal_list.dart';
import 'package:evently_app/features/map/presentation/views_model/map_cubit.dart';
import 'package:evently_app/features/map/presentation/views_model/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewBody extends StatelessWidget {
  const MapViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<MapCubit>(context);
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (previous, current) => current is GetLocationDataFailureState,
      listener: (context, state) {
        if (state is GetLocationDataFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        }
      },
      builder: (context, state) => Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            style: controller.nightMapStyle,
            initialCameraPosition: controller.initialCameraPosition,
            onMapCreated: (mapController) async {
              controller.googleMapController = mapController;
              await controller.updateMyCamera();
            },
            markers: controller.markers,
          ),
          Positioned(
            bottom: 32.h,
            left: 16,
            right: 16,
            child: const EventsHorizontalList(),
          )
        ],
      ),
    );
  }
}
