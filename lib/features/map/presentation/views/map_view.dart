import 'package:evently_app/features/map/presentation/views/widgets/map_floating_action_button.dart';
import 'package:evently_app/features/map/presentation/views/widgets/map_view_body.dart';
import 'package:evently_app/features/map/presentation/views_model/map_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit(context),
      child: const Scaffold(
        floatingActionButton: MapFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: MapViewBody(),
      ),
    );
  }
}
