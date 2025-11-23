import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/shop_owner_details/store_details/other_details.dart';
import 'package:dalil_2020_app/features/main/shop_owner_details/store_details/view.dart';
import 'package:dalil_2020_app/features/main/user_details/product_details/view.dart';
import 'package:dalil_2020_app/models/store_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../widgets/custom_back_button_in_container.dart';
import '../../../widgets/custom_name_and_rating.dart';
import '../../../widgets/custom_product_loading.dart';
import '../../../widgets/product_card_for_user.dart';
import '../../../widgets/service_for_shop_owner_in_store_details.dart';
import '../../controller/product_cubit/product_cubit.dart';

class StoreDetailsUserView extends StatefulWidget {
  const StoreDetailsUserView({
    super.key,
    required this.storeId,
    required this.storeImage,
    required this.storeName,
    required this.rating,
    required this.location,
    required this.phone,
    required this.address,
    required this.workTimes,
    required this.subCategoryName,
    required this.mainCategoryName,
  });
  final String storeImage;
  final String storeName;
  final String rating;
  final Location? location;

  final int storeId;
  final String subCategoryName;
  final String mainCategoryName;
  final String phone;
  final String address;
  final List<WorkingTime> workTimes;

  @override
  State<StoreDetailsUserView> createState() => _StoreDetailsUserViewState();
}

class _StoreDetailsUserViewState extends State<StoreDetailsUserView> {
  int activeIndex = 0;
  // final List<Product>
  @override
  Widget build(BuildContext context) {
    bool isEn = CachHelper.lang == 'en';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ProductCubit()..getAllProductsForShopForUser(widget.storeId)),
        BlocProvider(
          create: (context) =>
              StoreAndProductCubit()..getAllCommentsForStore(widget.storeId),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          leading: CustomBackButtonWithCircleContainer(
              color: AppColors.primary, isEn: isEn),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    images.isNotEmpty
                        ? CarouselSlider.builder(
                            itemCount: images.length,
                            itemBuilder: (context, index, realIndex) {
                              final url = images[index];
                              return Image.network(
                                url!,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(AppImages.products,
                                      fit: BoxFit.cover);
                                },
                              );
                            },
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.4,
                              viewportFraction: 1,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Image.asset(
                              AppImages.products,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                      bottom: 8,
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: images.length,
                        effect: WormEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.black,
                          dotColor: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNameAndItsRating(
                        rating: widget.rating,
                        name: widget.storeName,
                        color: AppColors.primary),
                    const SizedBox(height: 15),
                    ServiceForShopOwnerInStoreDetails(
                      category: widget.mainCategoryName,
                      subCategory: widget.subCategoryName,
                    ),
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      AppIcons.wave,
                    ),
                    const SizedBox(height: 20),
                    Text('Products'.tr(), style: kTextStyle18iUnderLine),
                    BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                      if (state is ProductLoading || state is AddStoreLoading) {
                        return Skeletonizer(
                            child: SizedBox(
                          height: context.read<ProductCubit>().products.length *
                              140.h,
                          child: const CustomProductLoading(
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              childAspectRatio: 1),
                        ));
                      }
                      if (state is GetProductsSuccess) {
                        final products = state.product;
                        return products.isEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                child: Text(
                                  "emptyProducts".tr(),
                                  style: TextStyle(
                                      color: AppColors.whiteAndBlackColor),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SizedBox(
                                height: products.length == 1
                                    ? MediaQuery.of(context).size.height * 0.3
                                    : products.length * 125.h,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 0.w),
                                  itemCount: products.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.8),
                                  itemBuilder: (context, index) {
                                    final product = products[index];
                                    return GestureDetector(
                                      onTap: () {
                                        print("objectddd ${product.images!}");
                                        AppNavigator.push(
                                            ProductDetailsUserView(
                                          isowner: true,
                                          sellername: widget.storeName,
                                          category: product.category!.isNotEmpty
                                              ? product.category![0]
                                              : '',
                                          subCategory:
                                              product.subCategory!.isNotEmpty
                                                  ? product.subCategory![0]
                                                  : '',
                                          description: isEn
                                              ? product.description?.en ?? ''
                                              : product.description?.ar ?? '',
                                          productId: product.id ?? 0,
                                          productImage: product.images!,
                                          rating:
                                              product.rating.toString() ?? "0",
                                          recentPrice: product.price ?? '',
                                          productName: isEn
                                              ? product.productName?.en ?? ''
                                              : product.productName?.ar ?? '',
                                          phone: widget.phone ?? '',
                                          saleType: product.saleType ?? '',
                                          oldPrice:
                                              product.priceAfterDiscount ?? '',
                                          userName: " product.sellerName" ?? '',
                                        ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: AppSize.getHeight(8),
                                            horizontal: 4),
                                        child: ProductCardForUser(
                                          storeId: widget.storeId,
                                          productImage:
                                              product.images!.isNotEmpty
                                                  ? product.images![0].url ?? ''
                                                  : '',
                                          productId: product.id ?? 0,
                                          recentPrice: product.price
                                                  ?.replaceAll(".00", "") ??
                                              '',
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
                      } else {
                        return const SizedBox(
                          height: 200,
                        );
                      }
                    }),
                    SvgPicture.asset(
                      AppIcons.wave,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => AppNavigator.push(OtherDetails(
                          workingTimes: widget.workTimes,
                          location: widget.location,
                          phone: widget.phone,
                          address: widget.address)),
                      child: Row(
                        spacing: 15,
                        children: [
                          Text(
                            "View Contact Details",
                            style: kTextStyle16Orange,
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CommentsStoreSection(
                      addComment: true,
                      storeId: widget.storeId,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
