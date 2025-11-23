import 'package:flutter/material.dart';
import '../../core/shared/widgets/custom_icon.dart';
import '../../core/style/app_colors.dart';
class CustomFieldWithHint extends StatelessWidget {
  const CustomFieldWithHint(
      {super.key,
         this.iconStart,
         this.hintText,
         this.controller,
        this.keyboardType,this.enabled=true,this.readOnly=false,this.initialValue,
        this.icon, this.iconColor, this.minLines, this.maxLength, this.maxLines});
  final String ?iconStart;
  final TextEditingController? controller;
  final String ?hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Widget? icon;
  final bool enabled;
  final bool readOnly;
  final Color?iconColor;
  final int ?minLines;
  final int ?maxLength;
  final int ?maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      controller: controller,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      minLines: minLines,
      style: TextStyle(color: AppColors.labelInputColor),
      decoration: InputDecoration(

          enabled:enabled ,
          icon: icon,
          hintStyle: TextStyle(fontSize: 12, color: AppColors.labelInputColor),
          prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIcon(
                  icon: iconStart,
                  color:iconColor?? AppColors.iconColor,
                ),
              ]),
          hintText: hintText),
    );
  }
}
