import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_size.dart';
import 'widgets/custom_city_drop_down.dart';

class CityAndCountryDropButton extends StatelessWidget {
  const CityAndCountryDropButton(
      {super.key,
      this.onChanged,
      this.value,
      this.padding,
      required this.label,
      this.cubit,
      this.color});
  final void Function(int?)? onChanged;
  final int? value;
  final EdgeInsetsGeometry? padding;
  final String label;
  final cubit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    print(cubit);
    return Container(
        width: double.infinity,
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: AppSize.getSize(3),
              horizontal: AppSize.getSize(3),
            ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.isDark()
                ? Colors.grey.shade900
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(AppSize.getSize(16)),
          color: AppColors.dropButtonColor,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: DropButtonWidget(
                  color: color ?? AppColors.primary,
                  cubit: cubit,
                  onChanged: onChanged,
                  value: value,
                  label: label)),
          Padding(
            padding: EdgeInsets.only(left: AppSize.getWidth(19)),
            child: CustomSvg(
              color: AppColors.dropButtonIconColor,
              svg: AppIcons.backArrow,
              width: AppSize.getWidth(12),
            ),
          )
        ]));
  }
}
