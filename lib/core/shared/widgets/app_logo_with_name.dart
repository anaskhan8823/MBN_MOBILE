import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../app_assets.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';

class AppLogoWithName extends StatelessWidget {
  const AppLogoWithName({super.key,this.hasName = true});
  final bool hasName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.logo,
          height: AppSize.getHeight(140),
        ),
        if (hasName) ...[
          Text(
            "app_name".tr(),
            style: TextStyle(
              fontSize: AppSize.getSize(22),
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ]

      ],
    );
  }
}
