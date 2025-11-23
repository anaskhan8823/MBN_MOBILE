import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/text_style.dart';

class CustomEyeView extends StatelessWidget {
  const CustomEyeView({
    super.key,
    required this.views,
    this.showViewWord = true,
    this.color,
  });

  final num views;
  final bool showViewWord;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSvg(
            svg: AppIcons.eyeOpen,
            color: color ?? AppColors.primary,
            width: 18),
        const SizedBox(width: 4),
        Row(
          spacing: 3,
          children: [
            Text('$views',
                style: kTextStyle13.copyWith(
                    color: AppColors.whiteAndBlackColor, fontSize: 12)),
            if (showViewWord) ...[
              Text('navHome.view'.tr(),
                  style: kTextStyle13.copyWith(
                      color: AppColors.whiteAndBlackColor)),
            ]
          ],
        ),
      ],
    );
  }
}
