// }
import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/all_shops/all_products_for_selling_and_rent_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/shop_details/view.dart';
import 'package:dalil_2020_app/features/widgets/custom_store_loading.dart';
import 'package:dalil_2020_app/features/widgets/empty_stores.dart';
import 'package:dalil_2020_app/features/widgets/search_screen.dart';
import 'package:dalil_2020_app/features/widgets/store_card_for_user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';

class AllShopsForUser extends StatelessWidget {
  final int? id; // class property

  AllShopsForUser({this.id, super.key});
  // final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => StoreAndProductCubit()
              ..getAllStoresForUser(id: id)
              ..getCategoriesfilter()),
        BlocProvider(
          create: (_) => LocationCubit(),
        ),
        BlocProvider(
          create: (_) => AllProductsForSellingAndRentCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final cubit = context.read<StoreAndProductCubit>();
          final locCubit = context.read<LocationCubit>();
          final sellingAndRentCubit =
              context.read<AllProductsForSellingAndRentCubit>();
          cubit.duscountID = id;
          return Scaffold(
            appBar: AuthAppbar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      ();
                      // Pass the existing cubits to the filter screen
                      AppNavigator.push(
                        BlocProvider.value(
                          value: sellingAndRentCubit,
                          child: BlocProvider.value(
                            value: cubit,
                            child: BlocProvider.value(
                              value: locCubit,
                              child: const CategoryView(
                                product: true,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.tune,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  ),
                ),
              ],
              title: "Shops",
              showLang: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
                  builder: (context, stateStore) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 10, left: 8, right: 08),
                      child: TextFormField(
                        controller: cubit.searchController,
                        style: kTextStyle14white.copyWith(
                            color: AppColors.primary),
                        decoration: InputDecoration(
                          suffixIcon: cubit.searchController.text.isNotEmpty
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.close,
                                      color: AppColors.primary),
                                  onPressed: () {
                                    cubit.searchController.text = "";
                                    cubit.getAllStoresForUserWithFilterCategory(
                                      cubit.selectedCategoryId,
                                      cubit.selectedSubCat,
                                      locCubit.countryId,
                                      locCubit.cityId,
                                      cubit.searchController.text,
                                      cubit.duscountID,
                                    );
                                  },
                                )
                              : IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.search,
                                      color: AppColors.primary),
                                  onPressed: () {
                                    cubit.getAllStoresForUserWithFilterCategory(
                                      cubit.selectedCategoryId,
                                      cubit.selectedSubCat,
                                      locCubit.countryId,
                                      locCubit.cityId,
                                      cubit.searchController.text,
                                      cubit.duscountID,
                                    );
                                  },
                                ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          hintText: "navHome.search".tr(),
                          hintStyle: kTextStyle16Orange.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          cubit.getAllStoresForUserWithFilterCategory(
                            cubit.selectedCategoryId,
                            cubit.selectedSubCat,
                            locCubit.countryId,
                            locCubit.cityId,
                            cubit.searchController.text,
                            cubit.duscountID,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              heightAppBar: 110,
            ),
            body: BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
              builder: (context, stateStore) {
                final cubit = context.read<StoreAndProductCubit>();
                if (stateStore is AddStoreLoading) {
                  return const Skeletonizer(child: StoresLoading());
                } else if (stateStore is GetStoresSuccess) {
                  // if (stateStore.stores.isEmpty) return const EmptyStores();
                  cubit.filters = [
                    //  if (searchController.value.text,.isNotEmpty) cubit.country.text,
                    if (cubit.country.value.text.isNotEmpty) cubit.country.text,
                    if (locCubit.selectedCity != null) locCubit.selectedCity!,
                    if (cubit.selectedCategory != null) cubit.selectedCategory!,
                    if (cubit.saleType != null) cubit.saleType!,
                    if (cubit.selectedSubCategory != null)
                      cubit.selectedSubCategory!,
                  ];

                  return Column(
                    children: [
                      cubit.filters.isNotEmpty
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 3,
                                children: cubit.filters.map((filter) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(
                                          20), // pill shape
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          filter,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const SizedBox(width: 6),
                                        GestureDetector(
                                          onTap: () {
                                            // print("object");
                                            if (filter ==
                                                cubit.country.value.text) {
                                              print("object");
                                              cubit.filters.remove(
                                                  cubit.country.value.text);
                                              locCubit.clearCountrySelection();

                                              cubit.country.text = "";
                                              cubit.getAllStoresForUser();
                                            } else if (filter ==
                                                locCubit.selectedCity) {
                                              print("object");
                                              locCubit.clearCitySelection();
                                              cubit.getAllStoresForUser();
                                            } else if (filter ==
                                                cubit.saleType) {
                                              print("object");
                                              cubit.saleType = null;
                                              cubit.getAllStoresForUser();
                                            } else if (filter ==
                                                cubit.selectedCategory) {
                                              print("object");
                                              cubit.selectedCategory = null;
                                              cubit.selectedCategoryId = null;
                                              cubit.selectedSubCategory = null;
                                              cubit.selectedSubCategory = null;
                                              cubit.getAllStoresForUser();
                                            } else if (filter ==
                                                cubit.selectedSubCategory) {
                                              print("object");
                                              cubit.selectedSubCategory = null;
                                              cubit.selectedSubCategory = null;
                                              cubit.getAllStoresForUser();
                                            }
                                            cubit.emit(cubit.state);
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            size: 18,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : SizedBox(),

                      const SizedBox(height: 05),
                      // Make GridView expand to fill remaining space

                      stateStore.stores.isNotEmpty
                          ? Expanded(
                              child: GridView.builder(
                                key: PageStorageKey('storeGridView'),
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                itemCount: stateStore.stores.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.75),
                                itemBuilder: (context, index) {
                                  final isEn =
                                      context.locale.languageCode == 'en';
                                  final store = stateStore.stores[index];

                                  return InkWell(
                                    onTap: () {
                                      AppNavigator.push(StoreDetailsUserView(
                                        mainCategoryName:
                                            store.category?.first ?? '',
                                        subCategoryName:
                                            store.subCategory?.first ?? '',
                                        address:
                                            store.contactInfo?.address ?? '',
                                        workTimes: store.workingTimes ?? [],
                                        location: store.location,
                                        phone:
                                            store.contactInfo?.mobileNumber ??
                                                '',
                                        storeId: store.id ?? 0,
                                        rating: store.rating!,
                                        storeName: isEn
                                            ? store.storeName?.en ?? ''
                                            : store.storeName?.ar ?? '',
                                        storeImage:
                                            store.images?.isNotEmpty == true
                                                ? store.images!
                                                : [],
                                      ));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppSize.getHeight(4),
                                        horizontal: AppSize.getWidth(4),
                                      ),
                                      child: StoreCardForUser(
                                        phone:
                                            store.contactInfo?.mobileNumber ??
                                                '',
                                        imageUrl:
                                            store.images?.isNotEmpty == true
                                                ? store.images![0].url ?? ''
                                                : '',
                                        rating: store.rating ?? "0",
                                        address:
                                            store.contactInfo?.address ?? '',
                                        storeName: isEn
                                            ? store.storeName?.en ?? ''
                                            : store.storeName?.ar ?? '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    spacing: 20,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "There are no stores available that match the selected search filters at the moment. Try changing the filters to see more results.",
                                        style: TextStyle(
                                            color:
                                                AppColors.whiteAndBlackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                      CustomButton(
                                        textSize: 12.sp,
                                        title: "Clear Search",
                                        textColor: AppColors.blackAndWhiteColor,
                                        width: AppSize.getWidth(200),
                                        onTap: () {
                                          // Clear country
                                          cubit.filters
                                              .remove(cubit.country.value.text);
                                          cubit.country.text = "";
                                          locCubit.clearCountrySelection();

                                          // Clear city
                                          locCubit.clearCitySelection();

                                          // Clear sale type
                                          cubit.saleType = null;

                                          // Clear category + subcategory
                                          cubit.selectedCategory = null;
                                          cubit.selectedCategoryId = null;
                                          cubit.selectedSubCategory = null;

                                          // Reload stores
                                          cubit.getAllStoresForUser();

                                          cubit.searchController.text = "";
                                          cubit
                                              .getAllStoresForUserWithFilterCategory(
                                            cubit.selectedCategoryId,
                                            cubit.selectedSubCat,
                                            locCubit.countryId,
                                            locCubit.cityId,
                                            cubit.searchController.text,
                                            cubit.duscountID,
                                          );

                                          // Notify UI
                                          cubit.emit(cubit.state);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
