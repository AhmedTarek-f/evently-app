import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Home Screen",
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}
