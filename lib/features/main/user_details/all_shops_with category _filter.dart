// import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
// import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
// import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';
// import 'package:dalil_2020_app/features/main/user_details/shop_details/view.dart';
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
// import '../../widgets/custom_store_loading.dart';
// import '../../widgets/search_screen.dart';
// import '../../widgets/store_card_for_user.dart';
// import '../controller/store_and_product_cubit/add_store_cubit.dart';

// class AllShopsForUserWithFilterCategory extends StatelessWidget {
//   const AllShopsForUserWithFilterCategory(
//       {super.key, required this.selectedCategoryId});
//   final int selectedCategoryId;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => StoreAndProductCubit()
//         ..getAllStoresForUserWithFilterCategory(selectedCategoryId),
//       child: Scaffold(
//           appBar: AuthAppbar(
//             onTap: () => AppNavigator.replace(const NavUserView()),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: GestureDetector(
//                     onTap: () {
//                       AppNavigator.replace(
//                         MultiBlocProvider(
//                           providers: [
//                             BlocProvider.value(
//                               value: context.read<StoreAndProductCubit>(),
//                             ),
//                             BlocProvider.value(
//                               value: context.read<LocationCubit>(),
//                             ),
//                           ],
//                           child: const CategoryView(),
//                         ),
//                       );
//                     },
//                     child: Icon(
//                       Icons.tune,
//                       color: AppColors.primary,
//                       size: 30,
//                     )),
//               )
//             ],
//             title: "Shops",
//             showLang: false,
//             bottom: PreferredSize(
//               preferredSize: const Size.fromHeight(40.0),
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
//                 child: GestureDetector(
//                   onTap: () => AppNavigator.push(CategoryView()),
//                   child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       height: 45,
//                       decoration: BoxDecoration(
//                           border:
//                               Border.all(color: AppColors.primary, width: 2),
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(18))),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "search",
//                             style: kTextStyle14white.copyWith(
//                                 color: AppColors.primary),
//                           ),
//                           Icon(
//                             Icons.search,
//                             color: AppColors.primary,
//                           ),
//                         ],
//                       )),
//                 ),
//               ),
//             ),
//             heightAppBar: 100,
//           ),
//           body: BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
//               builder: (context, stateStore) {
//             if (stateStore is AddStoreLoading) {
//               return const Skeletonizer(child: StoresLoading());
//             } else if (stateStore is GetStoresSuccess) {
//               if (stateStore.stores.isEmpty) {
//                 return Center(
//                   child: Text("emptyStores".tr(),
//                       style: TextStyle(
//                           color: AppColors.whiteAndBlackColor, fontSize: 16.sp),
//                       textAlign: TextAlign.center),
//                 );
//               }
//               return GridView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: 15.w),
//                 itemCount: Utils.items('', stateStore.stores.length),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2, childAspectRatio: 0.67),
//                 itemBuilder: (context, index) {
//                   final isEn = context.locale.languageCode == 'en';
//                   final stores = stateStore.stores[index];
//                   var store = stateStore.stores[index];
//                   return GestureDetector(
//                     onTap: () {
//                       AppNavigator.push(StoreDetailsUserView(
//                         mainCategoryName: store.category?.isNotEmpty == true
//                             ? store.category![0]
//                             : '',
//                         subCategoryName: store.subCategory?.isNotEmpty == true
//                             ? store.subCategory![0]
//                             : '',
//                         address: store.contactInfo?.address ?? '',
//                         workTimes: store.workingTimes ?? [],
//                         location: store.location,
//                         phone: store.contactInfo?.mobileNumber ?? '',
//                         storeId: store.id ?? 0,
//                         rating: store.rating.toString() ?? "0",
//                         storeName: isEn
//                             ? store.storeName?.en ?? ''
//                             : store.storeName?.ar ?? '',
//                         storeImage:
//                             (store.images != null && store.images!.isNotEmpty)
//                                 ? store.images![0].url ?? ''
//                                 : '',
//                       ));
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: AppSize.getHeight(8),
//                         horizontal: AppSize.getWidth(8),
//                       ),
//                       child: StoreCardForUser(
//                         phone: store.contactInfo?.mobileNumber ?? '',
//                         imageUrl:
//                             (store.images != null && store.images!.isNotEmpty)
//                                 ? store.images![0].url ?? ''
//                                 : '',
//                         rating: store.rating.toString() ?? "0",
//                         address: store.contactInfo?.address ?? '',
//                         storeName: isEn
//                             ? store.storeName?.en ?? ''
//                             : store.storeName?.ar ?? '',
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
