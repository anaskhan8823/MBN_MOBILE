import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../app_assets.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';
import 'custom_svg.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key, this.onTap, this.space});

  final double? space;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: space ?? AppSize.getHeight(125),
          ),
          CustomSvg(svg: AppSvg.error, height: AppSize.getHeight(225)),
          SizedBox(height: AppSize.getHeight(30)),
          Text(
            'profile.attachments.download_error'.tr(),
            style: TextStyle(fontWeight: FontWeight.bold, height: 1.8),
            textAlign: TextAlign.center,
          ),
          if (onTap != null) ...[
            SizedBox(height: AppSize.getHeight(30)),
            InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary.withValues(alpha: .2),
                ),
                padding: AppSize.padding(vertical: 8, horizontal: 16),
                child: Text(
                  'profile.attachments.refresh'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
