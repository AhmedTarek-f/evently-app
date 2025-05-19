import 'package:evently_app/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:evently_app/features/profile/presentation/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(),
      child: const ProfileViewBody(),
    );
  }
}
