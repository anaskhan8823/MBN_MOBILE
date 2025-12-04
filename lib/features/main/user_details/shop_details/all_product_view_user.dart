import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/product_details/view.dart';
import 'package:dalil_2020_app/features/widgets/custom_product_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../widgets/product_card_for_user.dart';
import '../../../../core/helper/app_navigator.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/cache/cache_helper.dart';
class AllProductsScreen extends StatelessWidget {
  final int id;
  final String storeName;
  final String phone;

  const AllProductsScreen({
    super.key,
    required this.id,
    required this.storeName,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    bool isEn = CachHelper.lang == 'en';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()..getAllProductsForShopForUser(id),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Products"),
          backgroundColor: AppColors.primary,
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading || state is AddStoreLoading) {
              return Skeletonizer(
                child: SizedBox(
                  height: context.read<ProductCubit>().products.length * 140.h,
                  child: const CustomProductLoading(
                    scrollDirection: Axis.vertical,
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                ),
              );
            }

            if (state is GetProductsSuccess) {
              final products = state.product;

              return products.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.16,
                      child: Text(
                        "emptyProducts".tr(),
                        style: TextStyle(color: AppColors.whiteAndBlackColor),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox(
                      height: products.length == 1
                          ? MediaQuery.of(context).size.height * 0.3
                          : products.length * 60.h,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                ProductDetailsUserView(
                                  isowner: true,
                                  sellername: storeName,
                                  category: product.category?.isNotEmpty == true
                                      ? product.category![0]
                                      : '',
                                  subCategory:
                                      product.subCategory?.isNotEmpty == true
                                          ? product.subCategory![0]
                                          : '',
                                  description: isEn
                                      ? product.description?.en ?? ''
                                      : product.description?.ar ?? '',
                                  productId: product.id ?? 0,
                                  productImage: product.images ?? [],
                                  rating: product.rating.toString(),
                                  recentPrice: product.price ?? '',
                                  productName: isEn
                                      ? product.productName?.en ?? ''
                                      : product.productName?.ar ?? '',
                                  phone: phone,
                                  saleType: product.saleType ?? '',
                                  oldPrice: product.priceAfterDiscount ?? '',
                                  userName: product.sellerName ?? '',
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppSize.getHeight(4),
                                horizontal: 4,
                              ),
                              child: ProductCardForUser(
                                rating: product.rating.toString(),
                                storeId: id,
                                productImage: product.images?.isNotEmpty == true
                                    ? product.images![0].url ?? ''
                                    : '',
                                productId: product.id ?? 0,
                                recentPrice:
                                    product.price?.replaceAll(".00", "") ?? '',
                                productName: isEn
                                    ? product.productName?.en ?? ''
                                    : product.productName?.ar ?? '',
                                oldPrice: product.priceAfterDiscount
                                        ?.replaceAll(".00", "") ??
                                    '',
                              ),
                            ),
                          );
                        },
                      ),
                    );
            }

            return const SizedBox(height: 200);
          },
        ),
      ),
    );
  }
}
