import 'dart:io';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/productive_families_details/product_details/view.dart';
import 'package:dalil_2020_app/features/widgets/custom_search_anchor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../constans.dart';
import '../../../../core/utils.dart';
import '../../../widgets/card_product_productive_card.dart';
import '../../../widgets/custom_loading_productive_card.dart';
import '../../../widgets/empty_products.dart';
import '../../controller/product_cubit/product_cubit.dart';
import '../../edit_product/view.dart';

class AllProductsProductiveFamiliesView extends StatelessWidget {
  const AllProductsProductiveFamiliesView({
    super.key,
    this.showAppBar,
    this.itemCount,
    this.padding,
    this.scrollDirection,
    this.crossAxisCount,
    this.childAspectRatio,
    this.viewFromWhere,
    required this.hideBackButton,
  });

  final bool? showAppBar;
  final bool hideBackButton;
  final int? itemCount;
  final Axis? scrollDirection;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final String? viewFromWhere;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit()..getAllProducts(),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          final cubit = context.read<ProductCubit>();

          return Scaffold(
            appBar: showAppBar == true
                ? null
                : AuthAppbar(
                    hideBackButton: hideBackButton,
                    color: AppColors.primaryProductive,
                    title: "homeProductive.myProducts",
                    showLang: false,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(40.0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 15, right: 15),
                        child: Builder(
                          builder: (searchContext) {
                            // Use a new context inside Builder
                            return CustomSearchAnchor(
                              color: AppColors.primaryProductive,
                              onChanged: (val) {
                                cubit.searchProductsLocally(val);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    heightAppBar: 100,
                  ),
            body: _buildBody(context, state, cubit),
          );
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, ProductState state, ProductCubit cubit) {
    if (state is ProductLoading) {
      return ProductProductiveLoading(
        scrollDirection: scrollDirection,
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
      );
    } else if (state is GetProductsSuccess) {
      final products = state.product;

      if (products.isEmpty) {
        return EmptyProducts(
          enterUser: kProductiveFamilies,
          editOrAdd: kAddProduct,
          color: AppColors.primaryProductive,
        );
      }

      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: padding ?? 15.w),
        scrollDirection: scrollDirection ?? Axis.vertical,
        itemCount: Utils.items(viewFromWhere ?? '', products.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount ?? 2,
          childAspectRatio: childAspectRatio ?? 0.6,
        ),
        itemBuilder: (context, index) {
          bool isEn = context.locale.languageCode == 'en';
          final product = products[index];

          return GestureDetector(
            onTap: () => _openProductDetails(context, cubit, product, isEn),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSize.getHeight(8), horizontal: 3.w),
              child: ProductProductiveCard(
                onEdit: () => _openEditProduct(context, product),
                productId: product.id ?? 0,
                onDeleteProduct: () => cubit.deleteProduct(product.id ?? 0),
                productImage: product.images!.isNotEmpty
                    ? product.images![0].url ?? ''
                    : '',
                productName: isEn
                    ? product.productName?.en ?? ''
                    : product.productName?.ar ?? '',
                recentPrice: product.priceAfterDiscount ?? '',
                price: product.price ?? '',
                numberOfOrders: product.orders ?? 0,
                numberOfRating: product.rating.toString() ?? "0",
                numberOfViews: product.totalViews ?? 0,
              ),
            ),
          );
        },
      );
    }

    return const SizedBox();
  }

  void _openProductDetails(
      BuildContext context, ProductCubit cubit, product, bool isEn) {
    AppNavigator.push(
      ProductDetailsView(
        price: product.priceAfterDiscount ?? '',
        onEditProduct: () => _openEditProduct(context, product),
        description: isEn
            ? product.description?.en ?? ''
            : product.description?.ar ?? '',
        productId: product.id ?? 0,
        productImages: product.images!.isNotEmpty ? product.images ?? '' : '',
        rating: product.rating.toString() ?? "0",
        views: product.totalViews ?? 0,
        onDelete: () => cubit.deleteProduct(product.id ?? 0),
        recentPrice: product.price ?? '',
        productName: isEn
            ? product.productName?.en ?? ''
            : product.productName?.ar ?? '',
        category: product.category!.isNotEmpty ? product.category![0] : '',
        subCategory:
            product.subCategory!.isNotEmpty ? product.subCategory![0] : '',
      ),
    );
  }

  void _openEditProduct(BuildContext context, product) async {
    List<File> files = [];
    if (product.images != null) {
      for (var img in product.images!) {
        final response = await HttpClient().getUrl(Uri.parse(img.url!));
        final bytes = await (await response.close())
            .fold<List<int>>([], (prev, e) => prev..addAll(e));
        final tempFile = File(
            '${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}.png');
        await tempFile.writeAsBytes(bytes);
        files.add(tempFile);
      }
    }

    AppNavigator.push(
      EditProduct(
        initialImages: files,
        saleType: product.saleType ?? '',
        mainCategory: product.category!.isNotEmpty ? product.category![0] : '',
        price: product.price ?? '',
        priceAfterDisc: product.priceAfterDiscount ?? '0',
        subCategory:
            product.subCategory!.isNotEmpty ? product.subCategory![0] : '',
        enterScreen: kProductiveFamilies,
        storeId: null,
        productId: product.id,
        arabicDescription: product.description?.ar ?? '',
        arabicName: product.productName?.ar ?? '',
        englishDescription: product.description?.en ?? '',
        englishName: product.productName?.en ?? '',
      ),
    );
  }
}
