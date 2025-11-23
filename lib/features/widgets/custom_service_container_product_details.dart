import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/style/app_size.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({super.key, this.svg, this.icon, required this.title});
  final Widget? svg;
  final IconData? icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: AppSize.getHeight(12), horizontal: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.whiteAndBlackColor)),
      child: Column(
        spacing: 4,
        children: [
          svg ?? Icon(icon, color: AppColors.iconColor),
          const SizedBox(width: 8),
          Text(title.tr(),
              style:
                  TextStyle(color: AppColors.whiteAndBlackColor, fontSize: 10)),
        ],
      ),
    );
  }
}
