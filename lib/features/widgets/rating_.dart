import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              CustomSvg(
                svg: AppIcons.star,
                height: 14.h,
                color: color ?? AppColors.primary,
              ),
              Text(
                rating.toString(),
                style: kTextStyle13.copyWith(
                    color: AppColors.whiteAndBlackColor, fontSize: 10),
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
              Text(
                _formatRating(rating),
                style: kTextStyle13.copyWith(
                  fontSize: 10,
                  color: AppColors.whiteAndBlackColor,
                ),
              )
            ],
          );
  }
}

String _formatRating(dynamic rating) {
  if (rating == null) return "0.0";

  final num? value = num.tryParse(rating.toString());
  if (value == null) return "0.0";

  return value.toStringAsFixed(1);
}
