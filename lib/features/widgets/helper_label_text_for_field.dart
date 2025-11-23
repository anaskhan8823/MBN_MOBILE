import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/style/app_colors.dart';
class HelperLabelTextForFiled extends StatelessWidget {
  const HelperLabelTextForFiled({
    super.key,
    required this.label,
  });
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:AppSize.getWidth(10),vertical: AppSize.getWidth(5)),
      child: Text(
        label.tr(),
        style: TextStyle(fontSize: 10, color: AppColors.labelInputColor),
      ),
    );
  }
}
