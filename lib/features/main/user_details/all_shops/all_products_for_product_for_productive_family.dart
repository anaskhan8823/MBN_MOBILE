// import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import '../../../../core/helper/app_navigator.dart';
// import '../../../../core/style/app_colors.dart';
// import '../../../../core/style/app_size.dart';
// import '../../../../core/style/text_style.dart';
// import '../../../../core/utils.dart';
// import '../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
// import '../../../widgets/custom_store_loading.dart';
// import '../../../widgets/empty_stores.dart';
// import '../../../widgets/search_screen.dart';
// import '../../../widgets/store_card_for_user.dart';
// import '../../controller/store_and_product_cubit/add_store_cubit.dart';
// import '../shop_details/view.dart';
// import 'all_products_for_selling_and_rent_cubit.dart';

// class AllProductsForProductForProductiveFamily extends StatelessWidget {
//   AllProductsForProductForProductiveFamily({super.key});
//   TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => AllProductsForSellingAndRentCubit()
//         ..getAllProductForProductiveFamily(),
//       child: Scaffold(
//           appBar: AuthAppbar(
//             actions: [],
//             title: context.tr("homeShopOwner.productive2"),
//             showLang: false,
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(40.0),
//               child: BlocBuilder<AllProductsForSellingAndRentCubit,
//                       AllProductsForSellingAndRentState>(
//                   builder: (context, stateStore) {
//                 return Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 10, left: 15, right: 1),
//                     child: TextFormField(
//                       style:
//                           kTextStyle14white.copyWith(color: AppColors.primary),
//                       decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                           padding: EdgeInsets.zero, // Removes internal padding
//                           constraints:
//                               BoxConstraints(), // Removes extra constraints
//                           icon: Icon(
//                             Icons.search,
//                             color: AppColors.primary,
//                           ),
//                           onPressed: () {
//                             context
//                                 .read<AllProductsForSellingAndRentCubit>()
//                                 .getAllProductForProductiveFamily(
//                                     searchText: searchController.text);
//                           },
//                         ),
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 15, horizontal: 10), // Adjusted padding
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(33),
//                           borderSide: BorderSide(color: AppColors.primary),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(33),
//                           borderSide: BorderSide(color: AppColors.primary),
//                         ),
//                         hintText: "navHome.search".tr(),
//                         hintStyle: kTextStyle16Orange.copyWith(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       onFieldSubmitted: (value) {
//                         context
//                             .read<AllProductsForSellingAndRentCubit>()
//                             .getAllProductForProductiveFamily(
//                                 searchText: value);
//                       },
//                       controller: searchController,
//                     ));
//               }),
//             ),
//             heightAppBar: 110,
//           ),
//           body: BlocBuilder<AllProductsForSellingAndRentCubit,
//                   AllProductsForSellingAndRentState>(
//               builder: (context, stateStore) {
//             if (stateStore.requestState == RequestStateEnum.loading) {
//               return const Skeletonizer(child: StoresLoading());
//             } else if (stateStore.requestState == RequestStateEnum.done) {
//               if (stateStore.stores.isEmpty) {
//                 return const EmptyStores();
//               }
//               return GridView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 15.w),
//                 itemCount: Utils.items('', stateStore.stores.length),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, childAspectRatio: 0.67),
//                 itemBuilder: (context, index) {
//                   final isEn = context.locale.languageCode == 'en';
//                   final stores = stateStore.stores[index];
//                   return GestureDetector(
//                     onTap: () {
//                       AppNavigator.push(StoreDetailsUserView(
//                         mainCategoryName: stores.category![0],
//                         subCategoryName: stores.subCategory![0],
//                         address: '',
//                         workTimes: [],
//                         location: null,
//                         phone: stores.sellerPhone ?? '',
//                         storeId: stores.id ?? 0,
//                         rating: (stores.rating ?? 0).toString(),
//                         storeName:
//                             // stores.productName.toString(),
//                             isEn
//                                 ? stores.productName!.en ?? ''
//                                 : stores.productName!.ar ?? '',
//                         storeImage:
//                             (stores.images != null && stores.images!.isNotEmpty)
//                                 ? stores.images!.first.url ?? ''
//                                 : '',
//                       ));
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                           vertical: AppSize.getHeight(8),
//                           horizontal: AppSize.getWidth(8)),
//                       child: StoreCardForUser(
//                         phone: stores.sellerPhone ?? '',
//                         imageUrl:
//                             (stores.images != null && stores.images!.isNotEmpty)
//                                 ? stores.images!.first.url ?? ''
//                                 : '',
//                         rating: (stores.rating ?? 0).toString(),
//                         address: '',
//                         storeName: stores.productName.toString(),
//                         // isEn
//                         //     ? stores.productName!.en ?? ''
//                         //     : stores.productName!.ar ?? '',
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return const SizedBox();
//           })),
//     );
//   }
// }
import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/main/productive_families_details/product_details/view.dart';
import 'package:dalil_2020_app/features/main/user_details/product_details/view.dart';
import 'package:dalil_2020_app/features/widgets/search_screen.dart';
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
import '../../../widgets/store_card_for_user.dart';
import '../../controller/store_and_product_cubit/add_store_cubit.dart';
import '../shop_details/view.dart';
import 'all_products_for_selling_and_rent_cubit.dart';

class AllProductsForProductForProductiveFamily extends StatelessWidget {
  const AllProductsForProductForProductiveFamily({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AllProductsForSellingAndRentCubit()
            ..getAllProductForProductiveFamily(),
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
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      AppNavigator.push(
                        BlocProvider.value(
                          value: sellingAndRentCubit,
                          child: BlocProvider.value(
                            value: cubit,
                            child: BlocProvider.value(
                              value: locCubit,
                              child: const CategoryView(
                                  product: true, families: true),
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
              title: context.tr("homeShopOwner.productive2"),
              showLang: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: BlocBuilder<AllProductsForSellingAndRentCubit,
                    AllProductsForSellingAndRentState>(
                  builder: (context, stateStore) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 15, right: 15),
                      child: TextFormField(
                        controller: cubit.searchController,
                        style: kTextStyle14white.copyWith(
                            color: AppColors.primary),
                        decoration: InputDecoration(
                          suffixIcon: cubit.searchController.text.isNotEmpty
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: Icon(Icons.close,
                                      color: AppColors.primary),
                                  onPressed: () {
                                    cubit.searchController.clear();
                                    sellingAndRentCubit
                                        .getAllProductForProductiveFamily(
                                      selectedCategoryId:
                                          cubit.selectedCategoryId,
                                      subcategoryId: cubit.selectedSubCat,
                                      selectedCountryId: locCubit.countryId,
                                      selectedCityId: locCubit.cityId,
                                      search: '',
                                      selltype: cubit.saleType,
                                    );
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.search,
                                      color: AppColors.primary),
                                  onPressed: () {
                                    sellingAndRentCubit
                                        .getAllProductForProductiveFamily(
                                      selectedCategoryId:
                                          cubit.selectedCategoryId,
                                      subcategoryId: cubit.selectedSubCat,
                                      selectedCountryId: locCubit.countryId,
                                      selectedCityId: locCubit.cityId,
                                      search: cubit.searchController.text,
                                      selltype: cubit.saleType,
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
                          sellingAndRentCubit.getAllProductForProductiveFamily(
                            selectedCategoryId: cubit.selectedCategoryId,
                            subcategoryId: cubit.selectedSubCat,
                            selectedCountryId: locCubit.countryId,
                            selectedCityId: locCubit.cityId,
                            search: cubit.searchController.text,
                            selltype: cubit.saleType,
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
                  if (stateStore.stores.isEmpty) return const EmptyStores();
                  cubit.filters = [
                    //  if (searchController.value.text,.isNotEmpty) cubit.country.text,
                    if (cubit.country.value.text.isNotEmpty) cubit.country.text,
                    if (locCubit.selectedCity != null) locCubit.selectedCity!,
                    if (cubit.selectedCategory != null) cubit.selectedCategory!,
                    if (cubit.selectedSubCategory != null)
                      cubit.selectedSubCategory!,
                  ];

                  return Column(children: [
                    cubit.filters.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 3,
                              children: cubit.filters.map((filter) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius:
                                        BorderRadius.circular(20), // pill shape
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
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        itemCount: Utils.items('', stateStore.stores.length),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.67,
                        ),
                        itemBuilder: (context, index) {
                          final isEn = context.locale.languageCode == 'en';
                          final stores = stateStore.stores[index];

                          return GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                ProductDetailsUserView(
                                  sellername: stores.productName.toString(),
                                  category: stores.category?.isNotEmpty == true
                                      ? stores.category![0]
                                      : '',
                                  subCategory:
                                      stores.subCategory?.isNotEmpty == true
                                          ? stores.subCategory![0]
                                          : '',
                                  description: isEn
                                      ? stores.productDescription?.en ?? ''
                                      : stores.productDescription?.ar ?? '',
                                  productId: stores.id ?? 0,
                                  productImage: stores.images ?? [],
                                  rating: stores.rating.toString() ?? "0",
                                  recentPrice: stores.price?.toString() ?? '',
                                  productName: isEn
                                      ? stores.productName?.en ?? ''
                                      : stores.productName?.ar ?? '',
                                  phone: stores.sellerPhone.toString(),
                                  saleType: stores.saleType ?? '',
                                  oldPrice:
                                      stores.priceAfterDiscount?.toString() ??
                                          '',
                                  userName: stores.sellerName ?? '',
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSize.getHeight(8),
                                horizontal: AppSize.getWidth(8),
                              ),
                              child: StoreCardForUser(
                                phone: stores.sellerPhone ?? '',
                                imageUrl: (stores.images?.isNotEmpty ?? false)
                                    ? stores.images!.first.url ?? ''
                                    : '',
                                rating: (stores.rating ?? 0).toString(),
                                address: '',
                                storeName: isEn
                                    ? (stores.productName?.en ?? '')
                                    : (stores.productName?.ar ?? ''),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]);
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
