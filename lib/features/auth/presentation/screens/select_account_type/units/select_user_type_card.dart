import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_size.dart';

class SelectUserTypeCard extends StatelessWidget {
  const SelectUserTypeCard({super.key, required this.title, this.onTap});
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: AppSize.padding(all: 16),
        decoration: BoxDecoration(
            color: AppColors.containerBackUserType.withValues(alpha:.1),
            borderRadius: BorderRadius.circular(AppSize.getSize(16))
        ),
        child:  Text(
          context.tr(title),
          textAlign: TextAlign.center,
          style: kTextStyle16white.copyWith(
            color: AppColors.isDark()?AppColors.white:AppColors.primary,

        )
        ),
      ),
    );
  }
}
