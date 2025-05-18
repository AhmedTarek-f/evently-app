import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventlyFloatingActionButton extends StatelessWidget {
  const EventlyFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      onPressed: () {},
      elevation: 0,
      shape: StadiumBorder(
        side: BorderSide(
          width: 5.r,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      child: Icon(
        Icons.add,
        size: 42.r,
      ),
    );
  }
}
