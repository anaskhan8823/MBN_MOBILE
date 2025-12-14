import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_slider.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/main/add_product/view.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:dalil_2020_app/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../../widgets/comments_products_productive.dart';
import '../../../widgets/custom_back_button_in_container.dart';
import '../../../widgets/custom_edit_and_delete_store_buttons.dart';
import '../../../widgets/custom_eye.dart';
import '../../../widgets/custom_name_and_rating.dart';
import '../../../widgets/service_for_shop_owner_in_store_details.dart';
import '../../../widgets/wavy_spacing.dart';
import '../../home/units/text_row_see_all.dart';
import '../all_products/view.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productImages,
    required this.productName,
    required this.rating,
    required this.views,
    required this.onDelete,
    required this.recentPrice,
    required this.price,
    required this.productId,
    required this.description,
    required this.onEditProduct,
    required this.category,
    required this.subCategory,
  });

  final List<ProductImage> productImages;
  final String productName;
  final String description;
  final String category;
  final String subCategory;
  final String rating;
  final num views;
  final void Function() onDelete;
  final void Function() onEditProduct;
  final String recentPrice;
  final String price;

  final int productId;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pink = AppColors.primaryProductive;
    bool isEn = CachHelper.lang == 'en';

    Widget imageSlider() {
      if (widget.productImages.isEmpty) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Image.asset(
            AppImages.wallet,
            height: MediaQuery.of(context).size.height * 0.42,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      }

      return CustomSlider(
        count: widget.productImages.length,
        position: currentIndex,
        height: MediaQuery.of(context).size.height * 0.42,
        updatePosition: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        item: (i) => ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          child: Image.network(
            widget.productImages[i].url!,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(AppImages.wallet, fit: BoxFit.cover);
            },
          ),
        ),
        // activeDotHeight: 3,
        // activeDotWidth: 20,
        // disActiveDotHeight: 3,
        // disActiveDotWidth: 10,
        activeColor: Colors.white,
      );
    }

    return BlocProvider(
      create: (context) =>
          ProductCubit()..getAllCommentsForProduct(widget.productId),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          leading: CustomBackButtonWithCircleContainer(color: pink, isEn: isEn),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              imageSlider(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNameAndItsRating(
                        rating: widget.rating,
                        name: widget.productName,
                        color: pink),
                    Row(
                      children: [
                        const SizedBox(width: 4),
                        CustomSvg(
                          svg: AppSvg.priceSolar,
                          color: pink,
                          width: 20,
                        ),
                        const SizedBox(width: 4),
                        Text("homeProductive.price".tr(),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryProductive)),
                        const SizedBox(width: 4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSvg(
                              svg: AppSvg.priceSolar,
                              color: AppColors.primaryProductive,
                              width: 18,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${widget.price.replaceAll(".00", "")}",
                                  style: kTextStyle10WhiteAndBlack.copyWith(
                                    decoration: TextDecoration
                                        .lineThrough, // Strikethrough
                                  ),
                                ),
                                Text(
                                  "/${widget.recentPrice}",
                                  style:
                                      kTextStyle10WhiteAndBlack, // Normal current price
                                ),
                              ],
                            ),
                            Text(
                              " sar".tr(),
                              style: kTextStyle10WhiteAndBlack,
                            ),
                          ],
                        ),
                        const Spacer(),
                        CustomEyeView(
                          color: pink,
                          views: widget.views,
                          showViewWord: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ServiceForShopOwnerInStoreDetails(
                      color: AppColors.whiteAndPinkColor,
                      subCategory: widget.subCategory,
                      category: widget.category,
                    ),
                    const SizedBox(height: 20),
                    WavySpacing(color: pink),
                    const SizedBox(height: 20),
                    Text('addProduct.storeDescription'.tr(),
                        style: kTextStyle20iUnderLinePink),
                    const SizedBox(height: 10),
                    Text(widget.description,
                        style: TextStyle(
                            color: AppColors.whiteAndGreyColor,
                            fontSize: 14.sp)),
                    const SizedBox(height: 10),
                    EditAndDeleteButtons(
                      color: pink,
                      onPressed: widget.onEditProduct,
                      onDelete: widget.onDelete,
                    ),
                    const SizedBox(height: 20),
                    WavySpacing(color: pink),
                    const SizedBox(height: 10),
                    TextSeeAll(
                        seeColor: AppColors.whiteAndBlackColor,
                        color: pink,
                        mainText: "homeProductive.other",
                        onPressed: () {
                          AppNavigator.push(
                              const AllProductsProductiveFamiliesView(
                            hideBackButton: false,
                          ));
                        }),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.37,
                        child: const AllProductsProductiveFamiliesView(
                          padding: 0,
                          hideBackButton: true,
                          showAppBar: true,
                          childAspectRatio: 1.7,
                          scrollDirection: Axis.horizontal,
                          crossAxisCount: 1,
                        )),
                    const SizedBox(height: 20),
                    CustomButton(
                      bgColor: pink,
                      iconColored: true,
                      iconColor: Colors.white,
                      icon: AppIcons.box,
                      height: 40,
                      textColor: AppColors.whiteAndBlackColor,
                      title: "addProduct.newProduct".tr(),
                      onTap: () {
                        AppNavigator.push(const AddProduct(
                          storeId: null,
                          enterScreen: kProductiveFamilies,
                        ));
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(22)),
                    ),
                    const SizedBox(height: 25),
                    WavySpacing(color: pink),
                    const SizedBox(height: 25),
                    CommentsForProductProductiveSection(color: pink),
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
