import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/text_style.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rating,
    this.color,
    required this.startFirst,
  });
  final String rating;
  final Color? color;
  final bool startFirst;
  @override
  Widget build(BuildContext context) {
    return startFirst == false
        ? Row(
            children: [
              Text(
                rating.toString(),
                style:
                    kTextStyle13.copyWith(color: AppColors.whiteAndBlackColor),
              ),
              CustomSvg(
                svg: AppIcons.star,
                color: color ?? AppColors.primary,
              ),
            ],
          )
        : Row(
            spacing: 5,
            children: [
              CustomSvg(
                svg: AppIcons.star,
                color: color ?? AppColors.primary,
                width: 22,
                height: 18,
              ),
              Text(rating.toString() ?? "",
                  style: kTextStyle13.copyWith(
                      fontSize: 14, color: AppColors.whiteAndBlackColor)),
            ],
          );
  }
}
