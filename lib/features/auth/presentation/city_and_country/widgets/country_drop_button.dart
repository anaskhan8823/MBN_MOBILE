import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/style/app_size.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/shared/widgets/custom_svg.dart';
import '../cubit/location_cubit.dart';

class CountryDropButton extends StatelessWidget {
  const CountryDropButton({
    super.key,
    required this.cubit,
    required this.onChanged,
    required this.value,
    required this.label,
    required this.isauth,
    this.color,
  });
  final LocationCubit cubit;
  final void Function(int? p1)? onChanged;
  final int? value;
  final String label;
  final Color? color;
  final bool isauth;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AppSize.getSize(3),
          horizontal: AppSize.getSize(12),
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
            child: DropdownButton<int>(
              underline: const SizedBox(),
              borderRadius: BorderRadius.circular(AppSize.getSize(16)),
              icon: const SizedBox(),
              hint: Row(
                spacing: AppSize.getWidth(10),
                children: [
                  CustomSvg(
                    color: color ?? AppColors.iconColor,
                    svg: AppIcons.country,
                    height: 19,
                  ),
                  Text(
                    label,
                    style: kTextStyle16white.copyWith(
                      color: AppColors.dropButtonTextColor,
                    ),
                  ),
                ],
              ),
              value: value,
              onChanged: onChanged != null
                  ? (val) {
                      if (val != null) {
                        if (isauth) {
                          final selectedCountry = cubit.countriesAndCode
                              .firstWhere((element) => element.id == val);
                        } else {
                          final selectedCountry = cubit.countriesAndCode
                              .firstWhere((element) => element.id == val);

                          final addCubit = context.read<StoreAndProductCubit>();

                          // ab uska name assign karo
                          addCubit.country.text =
                              selectedCountry.name.toString();
                          cubit.selectedCountry = selectedCountry.name;
                        }
                        // id se selected country object find karo

                        // context.read()
                      }

                      // external function call
                      if (onChanged != null) {
                        onChanged!(val);
                      }
                    }
                  : null,
              items: cubit.countriesAndCode.map(
                (e) {
                  return DropdownMenuItem<int>(
                    enabled: onChanged != null,
                    value: e.id,
                    child: Text(
                      "${e.name}",
                      style: kTextStyle16white.copyWith(
                        color: AppColors.dropButtonTextColor,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: AppSize.getWidth(12)),
            child: CustomSvg(
              svg: AppIcons.backArrow,
              color: AppColors.dropButtonIconColor,
              width: AppSize.getWidth(12),
            ),
          )
        ]));
  }
}
