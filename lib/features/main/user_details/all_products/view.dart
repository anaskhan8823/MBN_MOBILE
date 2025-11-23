import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/product_details/view.dart';
import 'package:dalil_2020_app/features/widgets/custom_search_anchor.dart';
import 'package:dalil_2020_app/features/widgets/product_card_for_user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_size.dart';
import '../../../widgets/custom_product_loading.dart';
import '../../../widgets/empty_products.dart';
import '../../edit_product/view.dart';
import '../../home/contact/presentation/controller/manager_chat_cubit.dart';

class AllProductsForUserView extends StatelessWidget {
  final String storeName;
  final String numberPhone;

  const AllProductsForUserView({
    super.key,
    required this.storeName,
    required this.numberPhone,
  });

  @override
  Widget build(BuildContext context) {
    bool isEn = context.locale.languageCode == 'en';
    return BlocProvider(
      create: (context) => ProductCubit()..getAllProductsForUser(),
      child: Scaffold(
          appBar: AuthAppbar(
            title: "homeProductive.myProducts",
            showLang: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                child: CustomSearchAnchor(onChanged: (val) {
                  context.read<ManagerChatCubit>().getContactFromSearch(val);
                }),
              ),
            ),
            heightAppBar: 100,
          ),
          body: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
            final cubit = context.read<ProductCubit>();
            if (state is ProductLoading) {
              return const Skeletonizer(
                  child: CustomProductLoading(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      childAspectRatio: 0.58));
            } else if (state is GetProductsSuccess) {
              if (state.product.isEmpty) {
                //chnaged here Kuser
                return const EmptyProducts(
                  enterUser: kUser,
                  editOrAdd: kAddProduct,
                );
              }
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                itemCount: state.product.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemBuilder: (context, index) {
                  final product = state.product[index];
                  return GestureDetector(
                    onTap: () {
                      AppNavigator.push(ProductDetailsUserView(
                        sellername: storeName,
                        category: product.category![0],
                        subCategory: product.subCategory![0],
                        description: isEn
                            ? product.description?.en ?? ''
                            : product.description?.ar ?? '',
                        productId: product.id ?? 0,
                        productImage: product.images!, // <-- use .url
                        rating: product.rating.toString() ?? "0",
                        recentPrice: product.priceAfterDiscount.toString(),
                        productName: isEn
                            ? product.productName?.ar ?? ''
                            : product.productName?.en ?? '',
                        phone: numberPhone,
                        saleType: product.saleType ?? '',
                        oldPrice: product.price.toString(),
                        userName: product.sellerName ?? '',
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: AppSize.getHeight(8), horizontal: 4),
                      child: ProductCardForUser(
                        putEditAndDeleteButtons: true,
                        onEdit: () {
                          AppNavigator.push(EditProduct(
                            initialImages: product.imageFiles!, // already Files
                            enterScreen: kUser,
                            productId: product.id,
                            saleType: product.saleType ?? '',
                            mainCategory: product.category![0],
                            priceAfterDisc: product.priceAfterDiscount ?? "0",
                            subCategory: product.subCategory![0],
                            price: product.price ?? '',
                            englishDescription: product.description?.en ?? '',
                            arabicDescription: product.description?.ar ?? '',
                            englishName: product.productName?.en ?? '',
                            arabicName: product.productName?.ar ?? '',
                            storeId: 0,
                          ));
                        },
                        storeId: 0,
                        onDeleteProduct: () {
                          cubit.deleteProductForUser(product.id ?? 0);
                        },
                        productImage:
                            product.images![0].url ?? '', // <-- use .url
                        category: product.category != null
                            ? product.category![0]
                            : '',
                        saleType: product.saleType ?? '',
                        productId: product.id ?? 0,
                        recentPrice:
                            product.price.toString().replaceAll(".00", ""),
                        productName: isEn
                            ? product.productName?.ar ?? ''
                            : product.productName?.en ?? '',
                        oldPrice: product.priceAfterDiscount
                            .toString()
                            .replaceAll(".00", ""),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          })),
    );
  }
}
