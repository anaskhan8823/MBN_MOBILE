import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/delivery_user_view/chat/data/model/contact_model.dart';
import 'package:dalil_2020_app/features/delivery_user_view/chat/data/repo/chat_repo_impel.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/home/contact/presentation/controller/manager_chat_cubit.dart';
import 'package:dalil_2020_app/features/main/home/contact/presentation/view/details_of_chat.dart';
import 'package:dalil_2020_app/features/main/home/map/presentation/control/map_stores_cubit.dart';
import 'package:dalil_2020_app/features/posts/presentation/widget/call.dart';
import 'package:dalil_2020_app/features/widgets/comments_product_section.dart';
import 'package:dalil_2020_app/features/widgets/customOutlineButton.dart';
import 'package:dalil_2020_app/features/widgets/custom_service_container_product_details.dart';
import 'package:dalil_2020_app/models/product_model.dart';
import 'package:dalil_2020_app/models/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../widgets/custom_back_button_in_container.dart';
import '../../../widgets/custom_name_and_rating.dart';
import '../../../widgets/service_for_shop_owner_in_store_details.dart';
import '../../controller/product_cubit/product_cubit.dart';

class ProductDetailsUserView extends StatefulWidget {
  const ProductDetailsUserView({
    super.key,
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.rating,
    required this.description,
    required this.phone,
    required this.saleType,
    required this.recentPrice,
    required this.oldPrice,
    required this.userName,
    required this.category,
    required this.subCategory,
    required this.sellername,
    this.isowner = false,
  });

  final List<ProductImage> productImage;
  final String productName;
  final String rating;
  final int productId;
  final String description;
  final String userName;
  final String category;
  final String subCategory;
  final String phone;
  final String saleType;
  final String recentPrice;
  final String oldPrice;
  final String sellername;
  final bool isowner;

  @override
  State<ProductDetailsUserView> createState() => _ProductDetailsUserViewState();
}

class _ProductDetailsUserViewState extends State<ProductDetailsUserView> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isEn = CachHelper.lang == 'en';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()..getAllProductsForShop(),
        ),
        BlocProvider(
          create: (context) => StoreAndProductCubit()
            ..getAllCommentsForProduct(widget.productId),
        ),
      ],
      child: Scaffold(
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
              // 🔥 Image Slider with Dots
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    widget.productImage.isNotEmpty
                        ? CarouselSlider.builder(
                            itemCount: widget.productImage.length,
                            itemBuilder: (context, index, realIndex) {
                              final url = widget.productImage[index].url;
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
                    // Positioned(
                    //   bottom: 8,
                    //   child: AnimatedSmoothIndicator(
                    //     activeIndex: activeIndex,
                    //     count: widget.productImage.length,
                    //     effect: WormEffect(
                    //       dotHeight: 8,
                    //       dotWidth: 8,
                    //       activeDotColor: Colors.black,
                    //       dotColor: Colors.grey.shade400,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              // 🔥 Details Section

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNameAndItsRating(
                        rating: widget.rating ?? "",
                        name: widget.productName,
                        color: AppColors.primary),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomSvg(svg: AppSvg.priceSolar),
                            const SizedBox(width: 3),
                            Text("${widget.oldPrice} ",
                                style: kTextStyle9GreyLineThrough),
                            Text(
                              "sar".tr(),
                              style: kTextStyle10WhiteAndBlack.copyWith(
                                  fontSize: 8),
                            ),
                            Text(
                              " / ",
                              style: kTextStyle10WhiteAndBlack.copyWith(
                                  fontSize: 8),
                            ),
                            Text("${widget.recentPrice} ",
                                style: kTextStyle10WhiteAndBlack),
                            Text(
                              "sar".tr(),
                              style: kTextStyle10WhiteAndBlack.copyWith(
                                  fontSize: 8),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "(For ${widget.saleType}) ",
                              style: kTextStyle13.copyWith(
                                  color: const Color(0xff74D778)),
                            ),
                            // Text('otherDetails.monthly'.tr(),
                            //     style:
                            //         kTextStyle13.copyWith(color: Colors.grey)),
                          ],
                        ),
                        // CustomSvg(svg: AppSvg.priceSolar),
                        // Text("${widget.recentPrice} ",
                        //     style: kTextStyle10WhiteAndBlack),
                        // Text(
                        //   "sar".tr(),
                        //   style:
                        //       kTextStyle10WhiteAndBlack.copyWith(fontSize: 8),
                        // ),
                        // const Spacer(),
                        // Text(
                        //   "addProduct.oldPrice".tr(),
                        //   style: TextStyle(
                        //       fontSize: AppSize.font(10),
                        //       color: AppColors.primary),
                        // ),
                        // Text(" ${widget.oldPrice} ",
                        //     style: kTextStyle9GreyLineThrough),
                        // Text(
                        //   "sar".tr(),
                        //   style:
                        //       kTextStyle10WhiteAndBlack.copyWith(fontSize: 8),
                        // ),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Text(
                    //       "(For ${widget.saleType}) ",
                    //       style: kTextStyle13.copyWith(
                    //           color: const Color(0xff74D778)),
                    //     ),
                    //     Text('otherDetails.monthly'.tr(),
                    //         style: kTextStyle13.copyWith(color: Colors.grey)),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    ServiceForShopOwnerInStoreDetails(
                      subCategory: widget.subCategory,
                      category: widget.category,
                    ),
                    const SizedBox(height: 18),
                    SvgPicture.asset(AppIcons.wave),
                    const SizedBox(height: 10),

                    Text('addProduct.storeDescription'.tr(),
                        style: TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: TextStyle(
                          color: AppColors.whiteAndGreyColor, fontSize: 12),
                    ),
                    // const SizedBox(height: 20),
                    // SvgPicture.asset(AppIcons.wave),
                    // const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("change.seller".tr(),
                            style: TextStyle(
                                color: AppColors.primaryDark,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        // Text("change.contact".tr(),
                        //     style: kTextStyle18iUnderLine),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            makeCall("+966530513564");
                          },
                          child: CategoryButton(
                              title: "Call",
                              svg: Icon(
                                Icons.call,
                                color: AppColors.whiteAndOrangeColor,
                              )),
                        )),
                        // Expanded(
                        //   child: CategoryButton(
                        //       title: "Location",
                        //       svg: Icon(
                        //         Icons.location_pin,
                        //         color: AppColors.whiteAndOrangeColor,
                        //       )),
                        // ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              openWhatsApp("+966530513564");
                            },
                            child: CategoryButton(
                                title: "WhatsApp",
                                svg: CustomSvg(
                                  svg: AppSvg.store,
                                  height: 20.h,
                                  width: 30.w,
                                  color: AppColors.whiteAndOrangeColor,
                                )),
                          ),
                        )
                      ],
                    ),

                    // const SizedBox(height: 10),
                    // SvgPicture.asset(AppIcons.wave),
                    const SizedBox(height: 20),
                    CommentsForProduct(
                        addComment: widget.isowner,
                        productId: widget.productId),
                    const SizedBox(height: 10),
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
