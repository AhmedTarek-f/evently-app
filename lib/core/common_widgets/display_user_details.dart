import 'package:evently_app/core/common_widgets/custom_elevated_button.dart';
import 'package:evently_app/core/common_widgets/dialogs/dialogs.dart';
import 'package:evently_app/core/constants/app_icons.dart';
import 'package:evently_app/core/constants/app_images.dart';
import 'package:evently_app/core/constants/app_text.dart';
import 'package:evently_app/core/utils/loaders/loaders.dart';
import 'package:evently_app/features/auth/register/data/models/user_model.dart';
import 'package:evently_app/features/start/presentation/views_model/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class DisplayUserDetails extends StatelessWidget {
  const DisplayUserDetails({
    super.key,
    required this.userData,
    this.isCreator = false,
  });
  final UserModel userData;
  final bool isCreator;
  @override
  Widget build(BuildContext context) {
    final startController = BlocProvider.of<StartCubit>(context);
    return GestureDetector(
      onTap: () => Dialogs.showOptionDialog(
        context: context,
        optionDialogContent: "",
        firstButtonTitle: "",
        secondButtonTitle: "",
        dialogContent: Padding(
          padding: REdgeInsetsDirectional.only(start: 16, end: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${AppText.userName} ${userData.userName}",
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const RSizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${AppText.userEmail} ${userData.email}",
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const RSizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: userData.email,
                        ),
                      );
                      Loaders.showSuccessMessage(
                        message: AppText.emailCopiedToClipBoard,
                        context: context,
                        secondsDuration: 1,
                      );
                    },
                    icon: SvgPicture.asset(
                      AppIcons.copy,
                      width: 24.r,
                      height: 24.r,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        dialogButton: CustomElevatedButton(
          width: ScreenUtil().screenWidth * 0.3,
          height: ScreenUtil().screenHeight * 0.05,
          onPressed: () {
            Navigator.of(context).pop();
          },
          titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
          buttonTitle: AppText.back,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: isCreator,
            child: Lottie.asset(
              startController.isDarkMode
                  ? AppImages.darkCrownAnimation
                  : AppImages.lightCrownAnimation,
              width: 52.r,
              height: 52.r,
              fit: BoxFit.contain,
            ),
          ),
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: CircleAvatar(
              radius: 24.r,
              backgroundColor: Theme.of(context).colorScheme.primaryFixed,
              backgroundImage: userData.photoUrl != null
                  ? NetworkImage(userData.photoUrl!)
                  : AssetImage(
                      userData.gender!.toLowerCase() == "male"
                          ? AppImages.maleUser
                          : AppImages.femaleUser,
                    ),
            ),
          ),
          const RSizedBox(height: 4),
          Text(
            userData.userName,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          )
        ],
      ),
    );
  }
}
