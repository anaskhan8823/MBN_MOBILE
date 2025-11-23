import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/text_style.dart';

class DetailsOfUserInHome extends StatelessWidget {
  const DetailsOfUserInHome(
      {super.key,
      this.borderRadius,
      required this.icon,
      required this.number,
      required this.label,
      this.style,
      this.borderColor});

  final BorderRadiusGeometry? borderRadius;
  final String icon;
  final String number;
  final String label;
  final TextStyle? style;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: borderColor ?? AppColors.primary),
          borderRadius: borderRadius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvg(
            svg: icon,
            height: 35,
            width: 35,
            color: borderColor ?? AppColors.primary,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 3,
            children: [
              Text(
                number.tr(),
                style: style ?? kTextStyle17,
              ),
              Text(
                label.tr(),
                style: style ??
                    TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
