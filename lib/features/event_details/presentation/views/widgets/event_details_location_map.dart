import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_cubit.dart';
import 'package:evently_app/features/event_details/presentation/views_model/event_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventDetailsLocationMap extends StatelessWidget {
  const EventDetailsLocationMap({super.key, required this.eventData});
  final EventModel eventData;
  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EventDetailsCubit>(context);
    return BlocBuilder<EventDetailsCubit, EventDetailsState>(
      builder: (context, state) => Container(
        width: ScreenUtil().screenWidth,
        height: 361.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurStyle: BlurStyle.outer,
              blurRadius: 6.r,
            )
          ],
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            scrollGesturesEnabled: false,
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            style: controller.nightMapStyle,
            initialCameraPosition: controller.initialCameraPosition,
            onMapCreated: (mapController) async {
              controller.googleMapController = mapController;
              await controller.animateCameraToEventLocation(
                  eventData: eventData);
            },
            markers: controller.markers,
          ),
        ),
      ),
    );
  }
}
