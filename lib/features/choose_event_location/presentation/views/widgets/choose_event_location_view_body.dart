import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/choose_event_location/presentation/views/widgets/select_location_button.dart';
import 'package:evently_app/features/choose_event_location/presentation/views_model/choose_event_location_cubit.dart';
import 'package:evently_app/features/choose_event_location/presentation/views_model/choose_event_location_state.dart';
import 'package:evently_app/features/create_event/presentation/views_model/create_event_cubit.dart';
import 'package:evently_app/features/edit_event/presentation/views_model/edit_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseEventLocationViewBody extends StatelessWidget {
  const ChooseEventLocationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<ChooseEventLocationCubit>(context);
    return BlocConsumer<ChooseEventLocationCubit, ChooseEventLocationState>(
      listenWhen: (previous, current) =>
          current is GetLocationDataFailureState ||
          current is SelectEventLocationState ||
          current is SelectEventLocationEditState,
      listener: (context, state) {
        if (state is GetLocationDataFailureState) {
          Loaders.showErrorMessage(
            message: state.errorMessage,
            context: context,
          );
        } else if (state is SelectEventLocationState) {
          final createEventController =
              BlocProvider.of<CreateEventCubit>(context);
          createEventController.selectEventLocation(
            eventLocation: controller.selectedLocation,
          );
          Navigator.of(context).pop();
        } else if (state is SelectEventLocationEditState) {
          final editEventController = BlocProvider.of<EditEventCubit>(context);
          editEventController.selectEventLocation(
            eventLocation: controller.selectedLocation,
          );
          Navigator.of(context).pop();
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
              controller.isEditEvent == true
                  ? controller.animateCameraToEventLocation()
                  : await controller.animateCameraToMyLocation();
            },
            onTap: (newEventLocation) => controller.changeSelectedLocation(
              eventLocation: newEventLocation,
            ),
            markers: controller.markers,
          ),
          Positioned(
              top: 32.h,
              child: BackButton(
                color: Theme.of(context).colorScheme.primary,
              )),
          const Positioned(
            bottom: 0,
            child: SelectLocationButton(),
          ),
        ],
      ),
    );
  }
}
