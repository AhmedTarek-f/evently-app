import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AnimationLoaderWidget extends StatelessWidget {
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    this.style,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: ScreenUtil().screenWidth * 0.8),
          const RSizedBox(
            height: 24,
          ),
          Text(
            text.tr(),
            style: style ?? Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
          const RSizedBox(
            height: 24,
          ),
          if (showAction)
            RSizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: onActionPressed,
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700),
                child: Text(
                  actionText?.tr() ?? "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
