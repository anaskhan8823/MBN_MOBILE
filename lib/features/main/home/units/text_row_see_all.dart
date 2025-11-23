import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/text_style.dart';

class TextSeeAll extends StatelessWidget {
  const TextSeeAll(
      {super.key,
      required this.mainText,
      required this.onPressed,
      this.color,
      this.moreDetails = false,
      this.seeColor,
      this.showSeeAll = true});
  final String mainText;
  final void Function()? onPressed;
  final Color? color;
  final bool showSeeAll;
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
        // showSeeAll?
        Visibility(
          visible: showSeeAll,
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              moreDetails == false
                  ? "homeShopOwner.seeAll".tr()
                  : "navHome.more".tr(),
              style: kTextStyle16white.copyWith(
                  fontSize: 14.sp,
                  color: seeColor ?? AppColors.primary,
                  fontWeight: FontWeight.w400),
            ),
          ),
        )
        // :const SizedBox()
      ],
    );
  }
}
