import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';
import '../../validators/app_validators.dart';
import 'custom_icon.dart';

class CustomFieldText extends StatelessWidget {
  final TextInputType keyboardType;

  const CustomFieldText({
    super.key,
    this.enabled = true,
    this.validator,
    this.labelText,
    this.controller,
    this.padding,
    this.onTap,
    this.onChanged,
    this.iconStart,
    this.iconEnd,
    this.iconEndTap,
    this.minLines,
    this.maxLines,
    this.prefixIcon,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.borderColor,
    this.suffixIcon,
    this.borderRadius,
    this.iconForEye,
    this.filled = false,
    required this.isRequired,
    this.fillColor,
    required this.errorText,
    this.icon,
    this.maxLength,
    this.hintText,
    this.iconColor,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? iconStart;
  final String? iconEnd;
  final bool isRequired;
  final Function()? iconEndTap;
  final String? errorText;
  final String? labelText;
  final int? maxLength;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final bool obscureText;
  final Widget? icon;
  final int? minLines;
  final int? maxLines;
  final bool enabled;
  final bool readOnly;
  final Icon? iconForEye;
  final bool? filled;
  final Color? fillColor;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Color? iconColor;

  final FormFieldValidator<String>? validator;

  final Color? borderColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ??
          (String? value) {
            if (isRequired == true) {
              return AppValidators.required(value);
            }
            return null;
          },
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
      maxLength: maxLength,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: AppColors.labelInputColor),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        label: Text(
          context.tr(
            labelText ?? "",
          ),
          style: TextStyle(fontSize: 12, color: AppColors.labelInputColor),
        ),
        icon: icon,
        hintText: hintText ?? "",
        errorText: errorText!.isNotEmpty ? errorText : null,
        suffixIconConstraints: BoxConstraints(
          minHeight: AppSize.getHeight(40),
          maxHeight: AppSize.getHeight(40),
        ),
        prefixIconConstraints: BoxConstraints(
          minHeight: AppSize.getHeight(40),
          maxHeight: AppSize.getHeight(40),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        prefixIcon: iconStart != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIcon(
                    icon: iconStart!,
                    width: AppSize.getSize(50),
                    color: iconColor ?? AppColors.iconColor,
                  ),
                ],
              )
            : null,
        suffixIcon: iconEnd != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIcon(
                    icon: iconEnd!,
                    onTap: iconEndTap,
                    width: AppSize.getSize(50),
                    color: iconColor ?? AppColors.iconColor,
                  ),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (suffixIcon != null) ...[
                    SizedBox(width: AppSize.getWidth(16)),
                    InkWell(
                        onTap: iconEndTap,
                        child: suffixIcon ?? SizedBox.shrink()),
                    SizedBox(width: AppSize.getWidth(16)),
                  ]
                ],
              ),
      ),
    );
  }
}
