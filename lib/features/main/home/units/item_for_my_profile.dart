import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
Widget buildMenuItem({
  required BuildContext context,
  required String icon,
  required String title,
  required VoidCallback onTap,
  Color? textColor,
  TextStyle?textStyle,
  Color?iconColor
}
)
{
  return SizedBox(
    height: 50.h,
    child: ListTile(
      visualDensity: const VisualDensity(horizontal: -3),
      title:
      Row(
        spacing: 12,
        children: [
          CustomSvg(svg:icon,color:iconColor ,width: 20.w,height: 20.h, ),
          Text(
           context.tr(title),
            style:textStyle??
                TextStyle(
                color: AppColors.whiteAndBlackColor,
                fontSize: 15,fontWeight: FontWeight.w500)
          ),
        ],
      ),
      onTap: onTap,
    ),
  );
}