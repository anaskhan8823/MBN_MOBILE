import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/style/app_size.dart';
class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton(
      {super.key,
        this.fixedSize,
      this.backgroundColor,
      required this.labelColor,
      required this.label,
      this.onPressed,
      this.side,  this.addIcon=false,  this.icon});
  final Color? backgroundColor;
  final Color labelColor;
  final String label;
  final BorderSide? side;
  final  Size? fixedSize;
  final void Function()? onPressed;
  final bool addIcon;
 final  Widget? icon;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: side,
        fixedSize:fixedSize?? Size.fromWidth(AppSize.getWidth(140)),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      child: Row(
        spacing: 2,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(addIcon==true)...[icon??const SizedBox()],
          Center(
            child: Text(
              label.tr(),
              style: TextStyle(color: labelColor,overflow: TextOverflow.ellipsis,
                  fontSize: 10.sp,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
