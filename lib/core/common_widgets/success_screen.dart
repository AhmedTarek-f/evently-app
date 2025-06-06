import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      this.onPressed,
      required this.isAnimation});
  final String image;
  final String title;
  final String subTitle;
  final bool isAnimation;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isAnimation
                ? Lottie.asset(
                    image,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                  )
                : Image.asset(
                    image,
                    width: MediaQuery.sizeOf(context).width * 0.6,
                  ),
            const RSizedBox(
              height: 32,
            ),
            Text(
              title.tr(),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const RSizedBox(
              height: 16,
            ),
            Text(
              subTitle.tr(),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const RSizedBox(
              height: 32,
            ),
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: CustomElevatedButton(
                onPressed: onPressed,
                buttonTitle: AppText.continueText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
