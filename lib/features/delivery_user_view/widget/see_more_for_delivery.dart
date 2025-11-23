import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';

class SeeMoreForDelivery extends StatelessWidget {
  const SeeMoreForDelivery({
    super.key,
    required this.mainText,
    required this.onPressed,
    this.color,
    this.moreDetails = false,
    this.seeColor,
  });
  final String mainText;
  final void Function()? onPressed;
  final Color? color;
  final Color? seeColor;
  final bool? moreDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(mainText.tr(),
            style: kTextStyle16Orange.copyWith(
              color: color ?? AppColors.primary,
              fontSize: AppSize.getSize(18),
            )),
        TextButton(
          onPressed: onPressed,
          child: Text(
            moreDetails == false
                ? "homeShopOwner.seeAll".tr()
                : "navHome.more".tr(),
            style: kTextStyle13.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
