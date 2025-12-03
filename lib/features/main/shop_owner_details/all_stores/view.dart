import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/utils.dart';
import '../../../widgets/custom_search_anchor.dart';
import '../../../widgets/custom_search_anchor_shop_owner.dart';
import '../../../widgets/custom_store_loading.dart';
import '../../../widgets/empty_stores.dart';
import '../../../widgets/storeCard.dart';
import '../../controller/store_and_product_cubit/add_store_cubit.dart';
import '../store_details/view.dart';

class AllStores extends StatefulWidget {
  const AllStores({super.key, required this.hideBackButton});
  final bool hideBackButton;

  @override
  State<AllStores> createState() => _AllStoresState();
}

class _AllStoresState extends State<AllStores> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  bool _loadingMore = false;
  void _onScroll() {
    final cubit = context.read<StoreAndProductCubit>();
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !cubit.isLoadingMore &&
        cubit.currentPage <= cubit.totalPages) {
      cubit.getAllStores(actionFromScreen: () => _updateLocalLoadingMore());
    }
  }

  _updateLocalLoadingMore() {
    setState(() {
      _loadingMore = !_loadingMore;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppbar(
        hideBackButton: widget.hideBackButton,
        title: "navHome.myStores",
        showLang: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
            child: CustomSearchAnchorShopOwner(),
          ),
        ),
        heightAppBar: 100,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<StoreAndProductCubit>().getAllStores(isRefresh: true);
        },
        child: BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
          builder: (context, stateStore) {
            print('stateStore:$stateStore');
            final cubit = context.read<StoreAndProductCubit>();

            if (stateStore is AddStoreLoading && cubit.stores.isEmpty) {
              return const Skeletonizer(child: StoresLoading());
            } else if (stateStore is GetStoresSuccess) {
              if (cubit.stores.isEmpty) return const EmptyStores();

              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      itemCount:
                          cubit.stores.length + 1, // Add 1 for the loader
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.67,
                      ),
                      itemBuilder: (context, index) {
                        if (index == cubit.stores.length) {
                          return const SizedBox();
                        }

                        final store = cubit.stores[index];
                        var stores = stateStore.stores[index];

                        String? firstProductDescription;
                        if (stores.products != null &&
                            stores.products!.isNotEmpty) {
                          firstProductDescription = stores.products![0].price;
                          print(
                              "imagesssssssssssssss $firstProductDescription");
                        } else {
                          firstProductDescription = null;
                          print("No products available for this store");
                        }

                        final isEn = context.locale.languageCode == 'en';

                        // print(
                        // "imagesssssssssssssss${stores.products![0].description}");

                        return GestureDetector(
                          onTap: () {
                            final hasProducts = stores.products != null &&
                                stores.products!.isNotEmpty;
                            final firstProductDescription = hasProducts
                                ? stores.products![0].description
                                : null;

                            print(firstProductDescription ??
                                "No products available");

                            print(firstProductDescription ??
                                "No products available");

// Navigation safe
                            AppNavigator.push(StoreDetailsScreen(
                              subCategoryName: stores.subCategory?[0] ?? '',
                              mainCategoryName: stores.category?[0] ?? '',
                              storeArabicDesc: stores.description?.ar ?? '',
                              storeArabicName: stores.storeName?.ar ?? '',
                              storeEnglishDesc: stores.description?.en ?? '',
                              storeEnglishName: stores.storeName?.en ?? '',
                              address: stores.contactInfo?.address ?? '',
                              phone: stores.contactInfo?.mobileNumber ?? '',
                              workingTimes: stores.workingTimes ?? [],
                              location: stores.location,
                              dialCode:
                                  stores.location?.country?.dialCode ?? '',
                              country: stores.location?.country?.name ?? '',
                              city: stores.location?.city?.name ?? '',
                              description: isEn
                                  ? stores.description?.en ?? ''
                                  : stores.description?.ar ?? '',
                              onDelete: () => cubit.deleteStore(stores.id!),
                              storeId: stores.id ?? 0,
                              rating: stores.rating.toString() ?? "0",
                              views: 0,
                              storeName: isEn
                                  ? stores.storeName?.en ?? ''
                                  : stores.storeName?.ar ?? '',
                              storeImage: (stores.images != null &&
                                      stores.images!.isNotEmpty)
                                  ? stores.images!.first.url ?? ''
                                  : '',
                              endDate: stores.subscriptionEndDate ?? '',
                              products:
                                  hasProducts ? stores.products! : [], // Safe
                            ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSize.getHeight(8),
                              horizontal: AppSize.getWidth(8),
                            ),
                            child: StoreCard(
                              imageUrl: (stores.images != null &&
                                      stores.images!.isNotEmpty)
                                  ? stores.images!.first.url ?? ''
                                  : '',
                              products: stores.productsCount ?? 0,
                              rating: stores.rating.toString() ?? "0.0",
                              storeName: isEn
                                  ? stores.storeName?.en ?? ''
                                  : stores.storeName?.ar ?? '',
                              views: 0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (_loadingMore == true) ...{
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    )
                  }
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
