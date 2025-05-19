import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Favorite Screen",
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
