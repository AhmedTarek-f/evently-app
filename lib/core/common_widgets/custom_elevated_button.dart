import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    this.backgroundColor,
    this.width,
    this.height,
    this.isText = true,
    this.child,
    this.borderColor,
  });
  final void Function()? onPressed;
  final String buttonTitle;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final bool isText;
  final Widget? child;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        side: BorderSide(color: borderColor ?? Colors.transparent),
        minimumSize: Size(
          width ?? ScreenUtil().screenWidth,
          height ?? 56.h,
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: isText
          ? Text(
              buttonTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
            )
          : child,
    );
  }
}
