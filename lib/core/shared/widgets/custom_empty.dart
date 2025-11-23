import 'package:flutter/material.dart';

import '../../app_assets.dart';
import '../../style/app_size.dart';
import 'custom_svg.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({
    super.key,
    this.svg,
    this.text,
    this.image,
    this.title,
    this.topSpace,
  });

  final String? svg;
  final String? text;
  final String? title;
  final String? image;
  final double? topSpace;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: AppSize.getHeight(topSpace ?? 125),
        ),
        if (image != null)
          Image.asset(image!, height: AppSize.getHeight(260))
        else
          CustomSvg(
            svg: svg ?? AppSvg.empty,
            height: AppSize.getHeight(260),
          ),
        if (title != null) ...[
          SizedBox(height: AppSize.getHeight(24)),
          Text(
            title!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppSize.font(16),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        SizedBox(
          height: title != null ? AppSize.getHeight(6) : AppSize.getHeight(24),
        ),
        Text(
          text ?? 'Nothing here!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSize.font(12),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
