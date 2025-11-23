import 'package:flutter/material.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/shared/widgets/custom_svg.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../cubit/location_cubit.dart';

class DropButtonWidget extends StatelessWidget {
  const DropButtonWidget({
    super.key,
    required this.cubit,
    required this.onChanged,
    required this.value,
    required this.label,
    this.color,
  });
  final LocationCubit cubit;
  final void Function(int?)? onChanged;
  final int? value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    print(cubit.cityModel);
    return DropdownButton<int>(
      menuWidth: 250,
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(AppSize.getSize(16)),
      icon: const SizedBox(),
      hint: Row(
        spacing: AppSize.getWidth(10),
        children: [
          CustomSvg(
            svg: AppIcons.city,
            height: 19,
            color: color ?? AppColors.iconColor,
          ),
          Text(label,
              style: kTextStyle16white.copyWith(
                  color: AppColors.dropButtonTextColor)),
        ],
      ),
      onChanged: onChanged,
      value: value,
      padding: const EdgeInsets.only(left: 10),
      items: cubit.cityModel.map(
        (e) {
          return DropdownMenuItem<int>(
            value: e.id,
            child: Text(
              e.name ?? "",
              style: kTextStyle16white.copyWith(
                color: AppColors.dropButtonTextColor,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
