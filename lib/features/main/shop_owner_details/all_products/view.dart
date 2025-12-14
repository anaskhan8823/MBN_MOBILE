import 'dart:io';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:dalil_2020_app/features/main/user_details/product_details/view.dart';
import 'package:dalil_2020_app/features/widgets/custom_search_anchor.dart';
import 'package:dalil_2020_app/features/widgets/product_card_for_shop_owner.dart';
import 'package:dalil_2020_app/models/store_model.dart';
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

class AllProductsForStoreShopOwnerView extends StatefulWidget {
  const AllProductsForStoreShopOwnerView({
    super.key,
    this.showAppBar = true,
    this.padding,
    this.itemCount,
    this.scrollDirection,
    this.crossAxisCount,
    this.childAspectRatio,
    this.storeId,
    this.viewFromWhere,
    this.products,
    required this.number,
    required this.name,
  });

  final bool? showAppBar;
  final int? itemCount;
  final Axis? scrollDirection;
  final int? crossAxisCount;
  final double? childAspectRatio;
  final int? storeId;
  final String? viewFromWhere;
  final double? padding;
  final List<Product>? products;
  final String number;
  final String name;

  @override
  State<AllProductsForStoreShopOwnerView> createState() =>
      _AllProductsForStoreShopOwnerViewState();
}

class _AllProductsForStoreShopOwnerViewState
    extends State<AllProductsForStoreShopOwnerView> {
  final ScrollController _scrollController = ScrollController();
  late final ProductCubit _cubit;

  // ✅ Local filtered list for search
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _cubit = ProductCubit();

    // load first page
    _cubit.getAllProductsForShop(page: 1, isRefresh: true);

    // initialize filtered list with all products
    _filteredProducts = widget.products ?? [];

    // listen for scroll to load more
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _cubit.getAllProductsForShop(page: _cubit.currentPage + 1);
      }
    });
  }

  // ✅ Local search filter function
  void _onSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredProducts = widget.products ?? [];
      });
    } else {
      setState(() {
        _filteredProducts = widget.products!
            .where((p) =>
                (p.productName?.en ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                (p.productName?.ar ?? '')
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  Future<File> urlToFile(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final tempDir = await getTemporaryDirectory();
    final file =
        File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future<List<File>> convertUrlsToFiles(List<String> urls) async {
    List<File> files = [];
    for (var url in urls) {
      files.add(await urlToFile(url));
    }
    return files;
  }

  @override
  Widget build(BuildContext context) {
    bool isEn = context.locale.languageCode == 'en';
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: widget.showAppBar == true
            ? AuthAppbar(
                title: "allProducts",
                showLang: false,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40.0),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    child: CustomSearchAnchor(
                      onChanged: (val) {
                        _onSearch(val); // ✅ Local filter
                      },
                    ),
                  ),
                ),
                heightAppBar: 100,
              )
            : null,
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading && _cubit.currentPage == 1) {
              return Skeletonizer(
                child: CustomProductLoading(
                  scrollDirection: widget.scrollDirection,
                  crossAxisCount: widget.crossAxisCount,
                  childAspectRatio: widget.childAspectRatio,
                ),
              );
            } else if (state is GetProductsSuccess) {
              if (_filteredProducts.isEmpty) {
                return const EmptyProducts(
                  enterUser: kShopOwner,
                  editOrAdd: kAddProduct,
                );
              }

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.crossAxisCount ?? 2,
                  childAspectRatio: widget.childAspectRatio ?? 0.54,
                ),
                controller: _scrollController,
                padding:
                    EdgeInsets.symmetric(horizontal: widget.padding ?? 15.w),
                scrollDirection: widget.scrollDirection ?? Axis.vertical,
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSize.getHeight(8),
                      horizontal: 4,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        AppNavigator.push(ProductDetailsUserView(
                          sellername: widget.name,
                          category: product.category?.isNotEmpty == true
                              ? product.category![0]
                              : '',
                          subCategory: product.subCategory?.isNotEmpty == true
                              ? product.subCategory![0]
                              : '',
                          description: isEn
                              ? product.description?.en ?? ''
                              : product.description?.ar ?? '',
                          productId: product.id ?? 0,
                          productImage: product.image ?? [],
                          rating: product.rating.toString() ?? "0",
                          recentPrice: product.price?.toString() ?? '',
                          productName: isEn
                              ? product.productName?.en ?? ''
                              : product.productName?.ar ?? '',
                          phone: widget.number,
                          saleType: product.saleType ?? '',
                          oldPrice:
                              product.priceAfterDiscount?.toString() ?? '',
                          userName: product.sellerName ?? '',
                        ));
                      },
                      child: ProductCardForShopOwner(
                        onEdit: () async {
                          List<File> files = [];
                          if (product.image != null &&
                              product.image!.isNotEmpty) {
                            files = await convertUrlsToFiles(
                              product.image!.map((e) => e.url ?? '').toList(),
                            );
                          }

                          AppNavigator.push(EditProduct(
                            initialImages: files,
                            enterScreen: kShopOwner,
                            productId: product.id,
                            saleType: product.saleType ?? '',
                            mainCategory:
                                (product.category?.isNotEmpty ?? false)
                                    ? product.category![0]
                                    : '',
                            priceAfterDisc: product.priceAfterDiscount ?? "0",
                            subCategory:
                                (product.subCategory?.isNotEmpty ?? false)
                                    ? product.subCategory![0]
                                    : '',
                            price: product.price ?? '',
                            englishDescription: product.description?.en ?? '',
                            arabicDescription: product.description?.ar ?? '',
                            englishName: product.productName?.en ?? '',
                            arabicName: product.productName?.ar ?? '',
                            storeId: widget.storeId,
                          ));
                        },
                        storeId: widget.storeId ?? 0,
                        onDeleteProduct: () =>
                            _cubit.deleteProductForShopOwner(product.id ?? 0),
                        productImage: (product.image?.isNotEmpty ?? false)
                            ? product.image![0].url ?? ''
                            : 'https://via.placeholder.com/150',
                        category: (product.category?.isNotEmpty ?? false)
                            ? product.category![0]
                            : '',
                        saleType: product.saleType ?? '',
                        productId: product.id ?? 0,
                        recentPrice:
                            product.price.toString().replaceAll(".00", ""),
                        productName: isEn
                            ? product.productName?.en ?? ''
                            : product.productName?.ar ?? '',
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
          },
        ),
      ),
    );
  }
}
