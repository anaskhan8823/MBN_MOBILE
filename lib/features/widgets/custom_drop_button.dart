import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_size.dart';

class CustomDropButton<T> extends StatelessWidget {
  const CustomDropButton({
    super.key,
    required this.dropButton,
    this.decoration,
    this.color,
  });

  final DropdownButton<T> dropButton; // typed now
  final Decoration? decoration;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppSize.getSize(3),
        horizontal: AppSize.getSize(8),
      ),
      decoration: decoration ??
          BoxDecoration(
            border:
                Border.all(color: AppColors.transparentAndGreyColor, width: 0),
            borderRadius: BorderRadius.circular(AppSize.getSize(16)),
            color: Theme.of(context)
                .dropdownMenuTheme
                .inputDecorationTheme
                ?.fillColor,
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dropButton,
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 5),
            child: CustomSvg(
              svg: AppIcons.backArrow,
              color: color ?? AppColors.whiteAndBlackColor,
            ),
          )
        ],
      ),
    );
  }
}
