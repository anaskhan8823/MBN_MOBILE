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

class EditStoreDetails extends StatelessWidget {
  const EditStoreDetails(
      {super.key,
      this.subCategoryName,
      this.mainCategoryName,
      this.subScriptionEndDate});
  final String? subCategoryName;
  final String? mainCategoryName;
  final String? subScriptionEndDate;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
        builder: (_, state) {
      final cubit = context.read<StoreAndProductCubit>();

      // cubit.getCategories();
      print("cubit.categoryModel[0].name , ${cubit.categoryModel}");
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
        child: Column(spacing: 19, children: [
          CustomDropButton(
            dropButton: DropdownButton<int>(
              value: cubit.selectedCategoryId,
              menuWidth: double.infinity,
              underline: const SizedBox(),
              icon: const SizedBox(),
              hint: Row(
                spacing: 5,
                children: [
                  CustomSvg(svg: AppSvg.category, color: AppColors.iconColor),
                  Text(
                    mainCategoryName ?? '',
                    style: TextStyle(color: AppColors.whiteAndBlackColor),
                  ),
                ],
              ),
              items: cubit.categoryModel.map((category) {
                return DropdownMenuItem<int>(
                  enabled: false,
                  value: category.id,
                  child: Text(
                    category.name ?? 'No Name',
                    style: kTextStyle16white.copyWith(
                      color: AppColors.dropButtonTextColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: null,
              // (value) {
              //   cubit.changeCategory(value);
              //   cubit.resetSubCategory();
              //   cubit.getCategories();
              // },
            ),
          ),
          CustomDropButton(
            dropButton: DropdownButton<int>(
              menuWidth: double.infinity,
              style: const TextStyle(color: Colors.white),
              icon: const SizedBox(),
              underline: const SizedBox(),
              value: cubit.selectedSubCat,
              onChanged: null,

              //  (int? value) {
              //   cubit.changeSubCategory(cubit.selectedSubCategory, value!);
              // },
              hint: Row(spacing: 5, children: [
                CustomSvg(svg: AppSvg.category, color: AppColors.iconColor),
                Text(
                  subCategoryName ?? '',
                  style: kTextStyle12whiteAndBlack.copyWith(
                      color: AppColors.whiteAndBlackColor),
                ),
              ]),
              items: cubit.subModel.map((subCategory) {
                return DropdownMenuItem<int>(
                    enabled: false,
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
          CustomDropButton(
            dropButton: DropdownButton<String>(
              menuWidth: double.infinity,
              style: const TextStyle(color: Colors.white),
              icon: const SizedBox(),
              underline: const SizedBox(),
              value: cubit.selectedDate,
              onChanged: null,
              // (String? value) {
              //   cubit.selectedDate = value;

              //   cubit.pickDate(value);
              // },
              hint: Row(spacing: 5, children: [
                CustomSvg(
                    svg: AppSvg.date, color: AppColors.whiteAndOrangeColor),
                Text(
                  subScriptionEndDate.toString(),
                  style: kTextStyle12whiteAndBlack.copyWith(
                      color: AppColors.whiteAndBlackColor),
                ),
              ]),
              items: cubit.listOfSubscriptionsDates.map((subCategory) {
                return DropdownMenuItem<String>(
                    enabled: false,
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
