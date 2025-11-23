import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/city_drop_button_provider.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/code_and_country_provider.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/all_shops/all_products_for_selling_and_rent_cubit.dart';
import 'package:dalil_2020_app/features/widgets/custom_drop_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/text_style.dart';

class CategoryView extends StatelessWidget {
  final bool product; // ✅ final banana best hai StatelessWidget me
  final bool families;
  const CategoryView({super.key, this.product = false, this.families = false});

  @override
  Widget build(BuildContext context) {
    bool isEn = context.locale.languageCode == 'en';

    final cubit = context.read<StoreAndProductCubit>();
    final locCubit = context.read<LocationCubit>();
    final sellingAndRentCubit =
        context.read<AllProductsForSellingAndRentCubit>();

    // cubit.getCategories();

    //  final locCubit = context.read<CategoryView>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Filters', style: kTextStyle16Orange),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
          builder: (context, addState) {
            return BlocBuilder<LocationCubit, LocationState>(
              builder: (_, state) {
                return Column(
                  children: [
                    /// ------------------ COUNTRY ------------------
                    // product
                    //     ?
                    CodeAndCountryDropButton(
                      padding: const EdgeInsets.only(right: 12),
                      value: locCubit.countryId ?? 0,
                      onChanged: (int? value) {
                        locCubit.changeCountry(locCubit.selectedValue, value);
                        locCubit.clearCitySelection();
                      },
                      codeAndNameOfCountry: false,
                      label:
                          cubit.country.text ?? context.tr('sign_up.country'),
                    ),
                    // : SizedBox(),

                    const SizedBox(height: 10),

                    /// ------------------ CITY ------------------

                    if (locCubit.countryId != null &&
                        cubit.country.text.isNotEmpty) ...[
                      // product
                      //     ?
                      CityAndCountryDropButton(
                        label:
                            locCubit.selectedCity ?? context.tr('sign_up.city'),
                        padding: const EdgeInsets.only(right: 12),
                        value: locCubit.cityId,
                        onChanged: (int? value) {
                          if (value != null) {
                            locCubit.cityId = value;
                            final cityName = locCubit.cityModel
                                .firstWhere((c) => c.id == value)
                                .name;
                            locCubit.selectedCity = cityName;
                            locCubit.changeCityAndId(cityName, value);
                          }
                        },
                        cubit: locCubit,
                      )
                      // : SizedBox()
                    ],
                    const SizedBox(height: 10),

                    /// ------------------ CATEGORY ------------------
                    // DropdownButtonFormField<int>(
                    //   value: cubit.selectedCategoryId,
                    //   items: cubit.categoryModel.map((category) {
                    //     return DropdownMenuItem<int>(
                    //       value: category.id,
                    //       child: Text(category.name ?? 'No Name'),
                    //     );
                    //   }).toList(),
                    //   onChanged: (value) {
                    //     if (value != null) {
                    //       cubit.selectedCategoryId = value;
                    //       print(value);
                    //       final catname = cubit.categoryModel
                    //           .firstWhere((c) => c.id == value)
                    //           .name;
                    //       cubit.selectedCategory = catname;
                    //       cubit.changeCategory(value);
                    //     }
                    //     // cubit.changeCategory(value);

                    //     // emits state, UI rebuilds immediately
                    //   },
                    //   decoration: InputDecoration(
                    //     labelText: 'category',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 20),

                    /// ------------------ APPLY BUTTON ------------------
                    ///
                    ///
                    ///
                    ///

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
                            Text('addProduct.allC'.tr(),
                                style: TextStyle(
                                    color: AppColors.whiteAndBlackColor)),
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
                          cubit.selectedCategoryId = value;
                          if (value == null) return;

                          // 1. Clear previous subcategory selection
                          if (cubit.selectedSubCategory != null) {
                            cubit.selectedSubCategory = null;
                            cubit.selectedSubCategoryIds.clear();
                            cubit.selectedSubCat = null;
                            cubit.subModel.clear();
                          }

                          // 2. Update category
                          cubit.changeCategory(value);

                          // 3. Assign category name
                          final catname = cubit.categoryModel
                              .firstWhere((c) => c.id == value)
                              .name;
                          cubit.selectedCategory = catname;

                          print("Selected category: $catname");
                          print(
                              "Selected category: ${cubit.selectedCategoryId}");
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
                            cubit.changeSubCategory(
                                cubit.selectedSubCategory, value!);
                          },
                          hint: Row(spacing: 5, children: [
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

                    ///
                    ///
                    ///
                    ///
                    product
                        ? CustomDropButton(
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
                                    color: AppColors.iconColor,
                                  ),
                                  Text(
                                    'addProduct.saleType'.tr(),
                                    style: TextStyle(
                                        color: AppColors.whiteAndBlackColor),
                                  ),
                                ],
                              ),
                              items: ['sell', 'rent'].map((type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type,
                                      style: kTextStyle16white.copyWith(
                                          color:
                                              AppColors.dropButtonTextColor)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                cubit.changeSellType(value);
                              },
                            ),
                          )
                        : SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        print(cubit.selectedSubCategory);
                        print(cubit.selectedContoury);

                        if (product && !families) {
                          cubit.getAllStoresForUserWithFilterCategory(
                            cubit.selectedCategoryId,
                            cubit.selectedSubCat,
                            locCubit.countryId,
                            locCubit.cityId,
                            cubit.searchController.text,
                            cubit.duscountID,
                          );
                          Navigator.pop(context);
                        } else if (families && product) {
                          sellingAndRentCubit.getAllProductForProductiveFamily(
                              selectedCategoryId: cubit.selectedCategoryId,
                              subcategoryId: cubit.selectedSubCat,
                              selectedCountryId: locCubit.countryId,
                              selectedCityId: locCubit.cityId,
                              search: cubit.searchController.text,
                              selltype: cubit.saleType);
                          Navigator.pop(context);
                        } else {
                          print(
                              "///////////////////////////////////////////////////////////////");
                          sellingAndRentCubit.getAllStoresForUser(
                            selectedCategoryId: cubit.selectedCategoryId,
                            subcategoryId: cubit.selectedSubCat,
                            selectedCountryId: locCubit.countryId,
                            selectedCityId: locCubit.cityId,
                            search: cubit.searchController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(context.tr('apply')),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
