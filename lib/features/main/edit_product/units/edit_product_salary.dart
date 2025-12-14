import 'package:dalil_2020_app/core/helper/app_loading.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/widgets/custom_field_with_hint_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/text_style.dart';
import '../../../widgets/custom_drop_button.dart';
import '../../controller/stepper_and_add_product_cubit.dart';
import '../../controller/store_and_product_cubit/add_store_cubit.dart';

class EditProductSalary extends StatelessWidget {
  const EditProductSalary(
      {super.key,
      this.color,
      this.saleType,
      this.mainCategory,
      this.subCategory,
      this.price,
      this.priceAfterDisc,
      this.disctype,
      this.discvalue});
  final Color? color;
  final String? saleType;
  final String? disctype;
  final String? discvalue;
  final String? mainCategory;
  final String? subCategory;
  final String? price;
  final String? priceAfterDisc;
  @override
  Widget build(BuildContext context) {
    final key = context.read<StepperAndNavAddProductCubit>().formKey;
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (context, state) {
        final cubit = context.read<StoreAndProductCubit>();
        if (state is EditProductLoading) {
          return AppLoading(
            color: color ?? AppColors.primary,
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: key,
            child: Column(
              spacing: 15,
              children: [
                Text(
                  "addProduct.fill".tr(),
                  style: TextStyle(
                      fontSize: 12, color: AppColors.whiteAndBlackColor),
                  textAlign: TextAlign.center,
                ),
                CustomFieldWithHint(
                  iconColor: color,
                  hintText: price.toString(),
                  iconStart: AppSvg.priceChangeRounded,
                  controller: cubit.priceBeforeDisc,
                ),
                CustomFieldWithHint(
                  controller: cubit.discVal,
                  iconColor: color,
                  hintText: discvalue.toString(),
                  iconStart: AppSvg.discountFill,
                ),
                // CustomDropButton(
                //   dropButton: DropdownButton<String>(
                //     style: const TextStyle(color: Colors.white),
                //     icon: const SizedBox(),
                //     underline: const SizedBox(),
                //     menuWidth: double.infinity,
                //     value: cubit.disType,
                //     hint: Row(
                //       spacing: 5,
                //       children: [
                //         CustomSvg(
                //           svg: AppSvg.saleType,
                //           color: color ?? AppColors.iconColor,
                //         ),
                //         Text(
                //           disctype.toString(),
                //           style: TextStyle(color: AppColors.whiteAndBlackColor),
                //         ),
                //       ],
                //     ),
                //     items: ['fixed', 'percent'].map((type) {
                //       return DropdownMenuItem<String>(
                //         value: type,
                //         child: Text(type,
                //             style: kTextStyle16white.copyWith(
                //                 color: AppColors.dropButtonTextColor)),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       cubit.changeDiscountType(value);
                //     },
                //   ),
                // ),

                CustomFieldWithHint(
                  iconColor: color,
                  hintText: priceAfterDisc.toString(),
                  iconStart: AppSvg.discountFill,
                  controller: cubit.priceAfterDisc,
                ),
                CustomDropButton(
                  dropButton: DropdownButton<String>(
                    style: const TextStyle(color: Colors.white),
                    icon: const SizedBox(),
                    underline: const SizedBox(),
                    menuWidth: double.infinity,
                    value: cubit.saleType,
                    hint: Row(
                      spacing: 5,
                      children: [
                        CustomSvg(
                          svg: AppSvg.saleType,
                          color: color ?? AppColors.iconColor,
                        ),
                        Text(
                          saleType ?? '',
                          style: TextStyle(color: AppColors.whiteAndBlackColor),
                        ),
                      ],
                    ),
                    items: ['sell', 'rent'].map((type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type,
                            style: kTextStyle16white.copyWith(
                                color: AppColors.dropButtonTextColor)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeSellType(value);
                    },
                  ),
                ),
                CustomDropButton(
                  dropButton: DropdownButton<int>(
                    style: const TextStyle(color: Colors.white),
                    // isExpanded: true,
                    icon: const SizedBox(),
                    underline: const SizedBox(),
                    value: cubit.selectedCategoryId,
                    hint: Row(
                      spacing: 5,
                      children: [
                        CustomSvg(
                          svg: AppSvg.category,
                          color: color ?? AppColors.iconColor,
                        ),
                        Text(mainCategory ?? '',
                            style:
                                TextStyle(color: AppColors.whiteAndBlackColor)),
                      ],
                    ),
                    items: cubit.categoryModel.map((category) {
                      return DropdownMenuItem<int>(
                          value: category.id,
                          child: Text(category.name ?? 'No Name',
                              style: kTextStyle16white.copyWith(
                                  color: AppColors.dropButtonTextColor)));
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeCategory(value);
                      if (cubit.selectedSubCategory != null) {
                        value = null;
                        cubit.clearCategorySelection();
                        cubit.getCategories();
                        cubit.changeCategory(value);
                      }
                    },
                  ),
                ),
                CustomDropButton(
                  dropButton: DropdownButton<int>(
                    menuWidth: double.infinity,
                    style: const TextStyle(color: Colors.white),
                    icon: const SizedBox(),
                    underline: const SizedBox(),
                    value: cubit.selectedSubCat,
                    onChanged: (int? value) {
                      cubit.changeSubCategory(
                          cubit.selectedSubCategory, value!);
                    },
                    hint: Row(spacing: 5, children: [
                      CustomSvg(
                          svg: AppSvg.category,
                          color: color ?? AppColors.iconColor),
                      Text(
                        subCategory ?? '',
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
            ),
          ),
        );
      },
    );
  }
}
