import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Map Screen",
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
