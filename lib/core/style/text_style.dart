import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_size.dart';

TextStyle get kTextStyle16Orange => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryDark,
    );
TextStyle get kTextStyle16white => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.isDark() ? AppColors.white : AppColors.primary,
    );
TextStyle get kTextStyle9GreyLineThrough => TextStyle(
    decorationThickness: 3,
    decoration: TextDecoration.lineThrough,
    decorationColor: AppColors.primary,
    fontSize: 10.sp,
    color: Colors.grey);
TextStyle get kTextStyle18iUnderLine => TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: AppColors.primary,
      color: Colors.orange,
      fontSize: AppSize.font(18),
      fontWeight: FontWeight.bold,
    );
TextStyle get kTextStyle20iUnderLinePink => TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: AppColors.primaryProductive,
      color: AppColors.primaryProductive,
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    );

TextStyle get kTextStyle18 => TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    );
TextStyle get kTextStyle17 => TextStyle(
      fontSize: 17.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.primary,
    );

TextStyle get kTextStyle20White => TextStyle(
      fontSize: AppSize.getSize(20),
      fontWeight: FontWeight.w600,
      color: AppColors.underlineColor,
    );
TextStyle get kTextStyle18UnderLine => TextStyle(
      fontSize: AppSize.getSize(16),
      fontWeight: FontWeight.w700,
      color: AppColors.primary,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.primary,
      decorationThickness: 2,
    );
TextStyle get kTextStyle18UnderLineWhite => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.white,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.underlineColor,
      decorationThickness: 2,
    );
TextStyle get kTextStyle16 => TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.primaryDark,
    );

TextStyle get kTextStyle14grey => TextStyle(
    fontSize: 13.sp, fontWeight: FontWeight.w400, color: AppColors.textGrey);
TextStyle get kTextStyle14whiteUnderLine => TextStyle(
      color: AppColors.primary,
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
TextStyle get kTextStyle14white => TextStyle(
      color: AppColors.textPrimary,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
    );
final kTextStyle10 = const TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.normal,
);
TextStyle get kTextStyle10WhiteAndBlack => TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: AppColors.whiteAndBlackColor,
    );
final kTextStyle10Amber = const TextStyle(
    fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xffD2AF24));
TextStyle get kTextStyle13 => TextStyle(
    fontSize: AppSize.getSize(14),
    fontWeight: FontWeight.w500,
    color: AppColors.isDark() ? Colors.white : Colors.black);

///new styles with theme colors
TextStyle get kTextStyle18White => TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.whiteAndBlackColor,
    );
final kTextStyle14WhiteAndBlack = TextStyle(
  fontSize: AppSize.getSize(15),
  fontWeight: FontWeight.bold,
);
TextStyle get kTextStyle12whiteAndBlack => TextStyle(
    color: AppColors.whiteAndBlackColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.normal);
final kTextStyle18Orange = TextStyle(
  color: Colors.orange,
  fontSize: AppSize.font(20),
  fontWeight: FontWeight.bold,
);
