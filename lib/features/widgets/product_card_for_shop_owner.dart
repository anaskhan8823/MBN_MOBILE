import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_assets.dart';
import '../../core/helper/dialogs.dart';
import '../../core/shared/widgets/custom_button.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_size.dart';
import '../../core/style/text_style.dart';

class ProductCardForShopOwner extends StatelessWidget {
  const ProductCardForShopOwner(
      {super.key,
      required this.recentPrice,
      required this.oldPrice,
      required this.onDeleteProduct,
      required this.productName,
      required this.productId,
      required this.productImage,
      required this.saleType,
      required this.category,
      required this.storeId,
      this.onEdit});
  final String recentPrice;
  final String oldPrice;
  final String productName;
  final int productId;
  final String productImage;
  final String saleType;
  final Function()? onDeleteProduct;
  final Function()? onEdit;

  final String category;
  final int storeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 2, color: AppColors.primary),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        spacing: 3,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                productImage,
                height: MediaQuery.of(context).size.height * 0.21,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImages.products,
                    height: MediaQuery.of(context).size.height * 0.17,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                spacing: AppSize.getHeight(6),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    productName,
                    style: kTextStyle16white.copyWith(fontSize: 14),
                    maxLines: 1, // only one line
                    overflow:
                        TextOverflow.ellipsis, // show ... if text is too long
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      CustomSvg(svg: AppSvg.skinCare),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(category,
                          style: TextStyle(
                              color: AppColors.whiteAndBlackColor,
                              fontSize: AppSize.font(12),
                              fontWeight: FontWeight.w400)),
                      const Spacer(),
                      Text(
                        "($saleType)",
                        style: TextStyle(
                            fontSize: AppSize.font(12),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffC6D549)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSvg(svg: AppSvg.priceSolar),
                      Text(" $oldPrice ", style: kTextStyle9GreyLineThrough),
                      Text(
                        "sar".tr(),
                        style: kTextStyle10WhiteAndBlack.copyWith(fontSize: 8),
                      ),
                      Text(
                        " / ",
                        style: kTextStyle10WhiteAndBlack.copyWith(fontSize: 8),
                      ),
                      Text("$recentPrice ", style: kTextStyle10WhiteAndBlack),
                      Text(
                        "sar".tr(),
                        style: kTextStyle10WhiteAndBlack.copyWith(fontSize: 8),
                      ),
                      // const Spacer(),
                      // Text(
                      //   "addProduct.oldPrice".tr(),
                      //   style: TextStyle(
                      //       fontSize: AppSize.font(10), color: AppColors.primary),
                      // ),
                      // Expanded(
                      //     child: Text(" $oldPrice ",
                      //         style: kTextStyle9GreyLineThrough)),
                      // Expanded(
                      //   child: Text(
                      //     "sar".tr(),
                      //     style:
                      //         kTextStyle10WhiteAndBlack.copyWith(fontSize: 8),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    spacing: AppSize.getWidth(10),
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomButton(
                          height: 40.h,
                          bgColor: AppColors.primary,
                          onTap: onEdit,
                          textSize: 12.sp,
                          title: "addProduct.edit".tr(),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            displayDeleteProductSheet(
                                context, null, onDeleteProduct);
                          },
                          child: Image.asset(
                            AppImages.deleteProduct,
                            width: 35,
                            height: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
