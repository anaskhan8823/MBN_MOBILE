import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_size.dart';
import '../cubit/location_cubit.dart';

class CodeDropButton extends StatelessWidget {
  const CodeDropButton({
    super.key,
    this.dialCode,
    required this.cubit,
    required this.onChange,
    required this.values,
  });
  final LocationCubit cubit;
  final void Function(String? p1)? onChange;
  final String? values;
  final String? dialCode;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppSize.getSize(3),
        horizontal: AppSize.getSize(10.w),
      ),
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColors.isDark() ? Colors.transparent : Colors.grey[200]!,
            width: 2),
        borderRadius: BorderRadius.circular(
          AppSize.getSize(16),
        ),
        color: AppColors.dropButtonColor,
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(AppSize.getSize(16)),
        icon: Icon(Icons.keyboard_arrow_down_rounded,
            color: AppColors.dropButtonIconColor),
        hint: Text(dialCode ?? 'code'.tr(),
            style: kTextStyle16white.copyWith(
                color: AppColors.dropButtonTextColor, fontSize: 14.sp)),
        onChanged: onChange,
        value: values,
        items: cubit.countriesAndCode.map(
          (e) {
            return DropdownMenuItem<String>(
              enabled: onChange != null,
              value: e.countryCode,
              child: Text("${e.countryCode ?? ''} ",
                  style: kTextStyle16white.copyWith(
                      color: AppColors.dropButtonTextColor)),
            );
          },
        ).toList(),
      ),
    );
  }
}
