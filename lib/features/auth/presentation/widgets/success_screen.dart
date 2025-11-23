import 'package:dalil_2020_app/core/shared/widgets/container_with_background_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ContainerWithBackgroundImage(
        image: AppColors.isDark()?AppImages.backgroundDarkNoSpace:AppImages.backgroundLightNoSpace,
        child: ListView(
          children: [
            const Row(),
            const AuthAppbar(
              title: "reset_password.reset_password",
              showLang: false,
            ),
            SizedBox(height: AppSize.getHeight(38)),
            CustomSvg(
              svg: AppIcons.success,
            ),
            SizedBox(height: AppSize.getHeight(8)),
            Text(
              context.tr( "success.success"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSize.font(32),
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: AppSize.getHeight(24)),
            Text(
              context.tr( "success.success_desc"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSize.font(16),
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
