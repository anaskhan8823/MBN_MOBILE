import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/product_details/view.dart';
import 'package:dalil_2020_app/features/widgets/product_card_for_user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';
import '../../../../core/utils.dart';
import '../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../widgets/custom_store_loading.dart';
import '../../../widgets/empty_stores.dart';
import '../../../widgets/search_screen.dart';
import '../../../widgets/store_card_for_user.dart';
import '../../controller/store_and_product_cubit/add_store_cubit.dart';
import '../shop_details/view.dart';
import 'all_products_for_selling_and_rent_cubit.dart';

class AllProductsForSellingAndRent extends StatelessWidget {
  AllProductsForSellingAndRent({
    super.key,
    required this.title,
    this.isRent = false,
  });

  final bool isRent;
  final String title;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AllProductsForSellingAndRentCubit()
            ..updateRent(isRent)
            ..getAllStoresForUser(),
        ),
        BlocProvider(
          create: (_) => StoreAndProductCubit()..getCategories(),
        ),
        BlocProvider(
          create: (_) => LocationCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final cubit = context.read<StoreAndProductCubit>();
          final locCubit = context.read<LocationCubit>();
          final sellingAndRentCubit =
              context.read<AllProductsForSellingAndRentCubit>();

          return Scaffold(
            appBar: AuthAppbar(
              // color: ,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    // onTap: () {
                    //   // Pass the existing cubits to the filter screen
                    //   AppNavigator.push(
                    //     BlocProvider.value(
                    //       value: cubit,
                    //       child: BlocProvider.value(
                    //         value: locCubit,
                    //         child: const CategoryView(),
                    //       ),
                    //     ),
                    //   );
                    // },
                    onTap: () {
                      // Pass the existing cubits to the filter screen
                      AppNavigator.push(
                        MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                                value: cubit), // StoreAndProductCubit
                            BlocProvider.value(
                                value: locCubit), // LocationCubit
                            BlocProvider.value(
                                value:
                                    sellingAndRentCubit), // AllProductsForSellingAndRentCubit
                          ],
                          child: const CategoryView(product: false),
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
              title: title,
              showLang: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: BlocBuilder<AllProductsForSellingAndRentCubit,
                    AllProductsForSellingAndRentState>(
                  builder: (context, stateStore) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: 10, left: 15, right: 1),
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
                                    sellingAndRentCubit.getAllStoresForUser(
                                      selectedCategoryId:
                                          cubit.selectedCategoryId,
                                      subcategoryId: cubit.selectedSubCat,
                                      selectedCountryId: locCubit.countryId,
                                      selectedCityId: locCubit.cityId,
                                      search: cubit.searchController.text,
                                    );
                                  },
                                )
                              : IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(Icons.search,
                                      color: AppColors.primary),
                                  onPressed: () {
                                    sellingAndRentCubit.getAllStoresForUser(
                                      selectedCategoryId:
                                          cubit.selectedCategoryId,
                                      subcategoryId: cubit.selectedSubCat,
                                      selectedCountryId: locCubit.countryId,
                                      selectedCityId: locCubit.cityId,
                                      search: cubit.searchController.text,
                                    );
                                  },
                                ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33),
                            borderSide: BorderSide(color: AppColors.primary),
                          ),
                          hintText: "navHome.search".tr(),
                          hintStyle: kTextStyle16Orange.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          context
                              .read<AllProductsForSellingAndRentCubit>()
                              .getAllStoresForUser(
                                selectedCategoryId: cubit.selectedCategoryId,
                                subcategoryId: cubit.selectedSubCat,
                                selectedCountryId: locCubit.countryId,
                                selectedCityId: locCubit.cityId,
                                search: cubit.searchController.text,
                              );
                        },
                      ),
                    );
                  },
                ),
              ),
              heightAppBar: 110,
            ),
            body: BlocBuilder<AllProductsForSellingAndRentCubit,
                AllProductsForSellingAndRentState>(
              builder: (context, stateStore) {
                if (stateStore.requestState == RequestStateEnum.loading) {
                  return const Skeletonizer(child: StoresLoading());
                } else if (stateStore.requestState == RequestStateEnum.done) {
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
                                          onTap: ()
                                              // {
                                              //   // print("object");
                                              //   if (filter ==
                                              //       cubit.country.value.text) {
                                              //     print("object");
                                              //     cubit.filters.remove(
                                              //         cubit.country.value.text);
                                              //     locCubit.clearCountrySelection();

                                              //     cubit.country.text = "";
                                              //     sellingAndRentCubit
                                              //         .getAllStoresForUser(
                                              //       selectedCategoryId:
                                              //           cubit.selectedCategoryId,
                                              //       subcategoryId:
                                              //           cubit.selectedSubCat,
                                              //       selectedCountryId:
                                              //           locCubit.countryId,
                                              //       selectedCityId: locCubit.cityId,
                                              //       search:
                                              //           cubit.searchController.text,
                                              //     );
                                              //   } else if (filter ==
                                              //       locCubit.selectedCity) {
                                              //     print("object");
                                              //     locCubit.clearCitySelection();
                                              //     sellingAndRentCubit
                                              //         .getAllStoresForUser(
                                              //       selectedCategoryId:
                                              //           cubit.selectedCategoryId,
                                              //       subcategoryId:
                                              //           cubit.selectedSubCat,
                                              //       selectedCountryId:
                                              //           locCubit.countryId,
                                              //       selectedCityId: locCubit.cityId,
                                              //       search:
                                              //           cubit.searchController.text,
                                              //     );
                                              //   } else if (filter ==
                                              //       cubit.selectedCategory) {
                                              //     print("object");
                                              //     cubit.selectedCategory = null;
                                              //     cubit.selectedCategoryId = null;
                                              //     cubit.selectedSubCategory = null;
                                              //     cubit.selectedSubCat = null;
                                              //     sellingAndRentCubit
                                              //         .getAllStoresForUser(
                                              //       selectedCategoryId:
                                              //           cubit.selectedCategoryId,
                                              //       subcategoryId:
                                              //           cubit.selectedSubCat,
                                              //       selectedCountryId:
                                              //           locCubit.countryId,
                                              //       selectedCityId: locCubit.cityId,
                                              //       search:
                                              //           cubit.searchController.text,
                                              //     );
                                              //   } else if (filter ==
                                              //       cubit.selectedSubCategory) {
                                              //     print("object");
                                              //     cubit.selectedSubCategory = null;

                                              //     cubit.selectedSubCat = null;
                                              //     sellingAndRentCubit
                                              //         .getAllStoresForUser(
                                              //       selectedCategoryId:
                                              //           cubit.selectedCategoryId,
                                              //       subcategoryId:
                                              //           cubit.selectedSubCat,
                                              //       selectedCountryId:
                                              //           locCubit.countryId,
                                              //       selectedCityId: locCubit.cityId,
                                              //       search:
                                              //           cubit.searchController.text,
                                              //     );
                                              //   }
                                              //   cubit.emit(cubit.state);
                                              // },
                                              {
                                            // print("object");
                                            if (filter ==
                                                cubit.country.value.text) {
                                              print("object");
                                              cubit.filters.remove(
                                                  cubit.country.value.text);
                                              locCubit.clearCountrySelection();

                                              cubit.country.text = "";
                                              sellingAndRentCubit
                                                  .getAllStoresForUser();
                                            } else if (filter ==
                                                locCubit.selectedCity) {
                                              print("object");
                                              locCubit.clearCitySelection();
                                              sellingAndRentCubit
                                                  .getAllStoresForUser();
                                            } else if (filter ==
                                                cubit.saleType) {
                                              print("object");
                                              cubit.saleType = null;
                                              sellingAndRentCubit
                                                  .getAllStoresForUser();
                                            } else if (filter ==
                                                cubit.selectedCategory) {
                                              print("object");
                                              cubit.selectedCategory = null;
                                              cubit.selectedCategoryId = null;
                                              cubit.selectedSubCategory = null;
                                              cubit.selectedSubCategory = null;
                                              sellingAndRentCubit
                                                  .getAllStoresForUser();
                                            } else if (filter ==
                                                cubit.selectedSubCategory) {
                                              print("object");
                                              cubit.selectedSubCategory = null;
                                              cubit.selectedSubCategory = null;
                                              sellingAndRentCubit
                                                  .getAllStoresForUser();
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
                      stateStore.stores.isNotEmpty
                          ? Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 04.w),
                                itemCount:
                                    Utils.items('', stateStore.stores.length),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.95, // same as before
                                ),
                                itemBuilder: (context, index) {
                                  final isEn =
                                      context.locale.languageCode == 'en';
                                  final stores = stateStore.stores[index];
                                  return GestureDetector(
                                    onTap: () {
                                      AppNavigator.push(
                                        ProductDetailsUserView(
                                          sellername:
                                              stores.productName.toString(),
                                          category:
                                              stores.category?.isNotEmpty ==
                                                      true
                                                  ? stores.category![0]
                                                  : '',
                                          subCategory:
                                              stores.subCategory?.isNotEmpty ==
                                                      true
                                                  ? stores.subCategory![0]
                                                  : '',
                                          description: isEn
                                              ? stores.productDescription?.en ??
                                                  ''
                                              : stores.productDescription?.ar ??
                                                  '',
                                          productId: stores.id ?? 0,
                                          productImage: stores.images ?? [],
                                          rating:
                                              stores.rating.toString() ?? "0",
                                          recentPrice:
                                              stores.price?.toString() ?? '',
                                          productName: isEn
                                              ? stores.productName?.en ?? ''
                                              : stores.productName?.ar ?? '',
                                          phone: stores.sellerPhone.toString(),
                                          saleType: stores.saleType ?? '',
                                          oldPrice: stores.priceAfterDiscount
                                                  ?.toString() ??
                                              '',
                                          userName: stores.sellerName ?? '',
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: AppSize.getHeight(4),
                                        horizontal: AppSize.getWidth(4),
                                      ),
                                      child: ProductCardForUser(
                                        productImage:
                                            stores.images?.isNotEmpty == true
                                                ? stores.images![0].url ?? ''
                                                : '',
                                        rating: (stores.rating ?? 0).toString(),
                                        productName: isEn
                                            ? stores.productName?.en ?? ''
                                            : stores.productName?.ar ?? '',
                                        recentPrice: stores.price.toString(),
                                        oldPrice: stores.priceAfterDiscount
                                            .toString(),
                                        productId: stores.id!,
                                        storeId: 0,
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
                                          sellingAndRentCubit
                                              .getAllStoresForUser();

                                          cubit.searchController.text = "";
                                          // cubit
                                          //     .getAllStoresForUserWithFilterCategory(
                                          //   cubit.selectedCategoryId,
                                          //   cubit.selectedSubCat,
                                          //   locCubit.countryId,
                                          //   locCubit.cityId,
                                          //   cubit.searchController.text,
                                          //   cubit.duscountID,
                                          // );

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
