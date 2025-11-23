import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/shared/widgets/custom_svg.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../widgets/custom_drop_button.dart';

class Details extends StatelessWidget {
  const Details({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
        builder: (_, state) {
      final cubit = context.read<StoreAndProductCubit>();
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
        child: Column(spacing: 19, children: [
          CustomDropButton<int>(
            dropButton: DropdownButton<int>(
              menuWidth: double.infinity,
              style: const TextStyle(color: Colors.white),
              icon: const SizedBox(),
              underline: const SizedBox(),
              value: cubit.selectedCategoryId,
              hint: Row(
                spacing: 5,
                children: [
                  CustomSvg(
                    svg: AppSvg.category,
                    color: AppColors.whiteAndOrangeColor,
                  ),
                  Text(
                    "addStore.all".tr(),
                    style: kTextStyle12whiteAndBlack.copyWith(
                        color: AppColors.whiteAndBlackColor),
                  )
                ],
              ),
              items: cubit.categoryModel.map((category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Text(
                    category.name ?? 'No Name',
                    style: kTextStyle16white.copyWith(
                        color: AppColors.dropButtonTextColor),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                cubit.changeCategory(value);
                // Reset subcategory if needed
                if (cubit.selectedSubCategory != null) {
                  cubit.clearCategorySelection();
                  cubit.getCategories();
                }
              },
            ),
          ),
          if (cubit.selectedCategoryId != null &&
              cubit.selectedCategoryId != 0) ...[
            CustomDropButton(
              dropButton: DropdownButton<int>(
                menuWidth: double.infinity,
                style: const TextStyle(color: Colors.white),
                icon: const SizedBox(),
                underline: const SizedBox(),
                value: cubit.selectedSubCat,
                onChanged: (int? value) {
                  cubit.changeSubCategory(cubit.selectedSubCategory, value!);
                },
                hint: Row(spacing: 5, children: [
                  CustomSvg(
                      svg: AppSvg.category,
                      color: AppColors.whiteAndOrangeColor),
                  Text(
                    "addStore.sub".tr(),
                    style: kTextStyle12whiteAndBlack.copyWith(
                        color: AppColors.whiteAndBlackColor),
                  ),
                ]),
                items: cubit.subModel.map((subCategory) {
                  return DropdownMenuItem<int>(
                      onTap: () {
                        cubit.changeSubCategory(
                            subCategory.name, subCategory.id ?? 0);
                      },
                      value: subCategory.id,
                      child: Text(subCategory.name ?? 'No Name',
                          style: kTextStyle16white.copyWith(
                              color: AppColors.dropButtonTextColor)));
                }).toList(),
              ),
            ),
          ],
          CustomDropButton(
            dropButton: DropdownButton<String>(
              menuWidth: double.infinity,
              style: const TextStyle(color: Colors.white),
              icon: const SizedBox(),
              underline: const SizedBox(),
              value: cubit.selectedDate,
              onChanged: (String? value) {
                cubit.selectedDate = value;

                cubit.pickDate(value);
              },
              hint: Row(spacing: 5, children: [
                CustomSvg(
                    svg: AppSvg.date, color: AppColors.whiteAndOrangeColor),
                Text(
                  "addStore.date2".tr(),
                  style: kTextStyle12whiteAndBlack.copyWith(
                      color: AppColors.whiteAndBlackColor),
                ),
              ]),
              items: cubit.listOfSubscriptionsDates.map((subCategory) {
                return DropdownMenuItem<String>(
                    onTap: () {
                      cubit.selectedDate = subCategory;

                      cubit.pickDate(subCategory);
                    },
                    value: subCategory,
                    child: Text(subCategory ?? 'No Name',
                        style: kTextStyle16white.copyWith(
                            color: AppColors.dropButtonTextColor)));
              }).toList(),
            ),
          ),
        ]),
      );
    });
  }
}
