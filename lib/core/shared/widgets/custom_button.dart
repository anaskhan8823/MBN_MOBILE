import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';
import 'custom_icon.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.icon,
    this.onTap,
    this.width,
    this.height,
    this.bgColor,
    this.textColor,
    this.iconSize,
    this.iconColored,
    this.textSize,
    this.borderColor,
    required this.title,
    this.loading = false, this.fontWeight, this.borderRadius, this.mainAxisAlignment, this.iconColor,
  });

  final String title;
  final bool loading;
  final String? icon;
  final double? width;
  final FontWeight? fontWeight;
  final double? height;
  final double? iconSize;
  final double? textSize;
  final Color? bgColor;
  final Color? textColor;
  final bool? iconColored;
  final Color?iconColor;
  final void Function()? onTap;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      borderRadius: BorderRadius.circular(AppSize.getHeight(16)),
      child: Container(
        width: width ?? double.infinity,
        height: height ??50,
        padding: AppSize.padding(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius:borderRadius?? BorderRadius.circular(AppSize.getSize(16)),
          color: loading
              ? bgColor??AppColors.buttonPrimary
              : bgColor ?? AppColors.buttonPrimary,
          border: borderColor != null && !loading
              ? Border.all(color: borderColor!)
              : null,
        ),
        child: Row(
          mainAxisAlignment:mainAxisAlignment?? MainAxisAlignment.center,
          children: [
            if (loading)
              SizedBox(
                width: AppSize.getSize(26),
                height: AppSize.getSize(26),
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.white,
                ),
              )
            else ...[
              if (icon != null) ...[
                CustomIcon(
                  icon: icon,
                  width: AppSize.getSize(iconSize??24),
                  height: AppSize.getSize(iconSize??24),
                  // withColor: iconColored ?? false,
                  color: iconColor ?? AppColors.textColor,
                ),
                SizedBox(width: AppSize.getWidth(8)),
              ],
              Flexible(
                child: Text(
                  title.tr(),
                  style: TextStyle(
                    fontWeight:fontWeight?? FontWeight.bold,
                    fontSize: textSize ?? 15.sp,
                    color: textColor ?? AppColors.textButtonsColor,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
