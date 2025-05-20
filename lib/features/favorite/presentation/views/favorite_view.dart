import 'package:evently_app/features/favorite/presentation/views/widgets/favorite_view_body.dart';
import 'package:evently_app/features/favorite/presentation/views_model/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (context) => FavoriteCubit(),
      child: const SafeArea(
        child: FavoriteViewBody(),
      ),
    );
  }
}
