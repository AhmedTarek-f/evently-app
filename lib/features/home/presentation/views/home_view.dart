import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "HomeScreen",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
