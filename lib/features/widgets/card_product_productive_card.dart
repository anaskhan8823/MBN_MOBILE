import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/text_style.dart';
import 'custom_edit_and_delete_product_buttons.dart';
import 'custom_eye.dart';
import 'rating_.dart';

class ProductProductiveCard extends StatelessWidget {
  const ProductProductiveCard(
      {super.key,
      required this.recentPrice,
      required this.productName,
      required this.numberOfOrders,
      required this.numberOfViews,
      required this.numberOfRating,
      required this.productImage,
      required this.onDeleteProduct,
      this.productId,
      required this.onEdit});
  final String recentPrice;
  final num numberOfOrders;
  final num numberOfViews;
  final String productName;
  final String numberOfRating;
  final String productImage;
  final void Function() onDeleteProduct;
  final int? productId;
  final void Function() onEdit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 2, color: AppColors.primaryProductive),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        spacing: 4,
        children: [
          Expanded(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  productImage,
                  height: MediaQuery.of(context).size.height * 0.21,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.wallet,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.21,
                    );
                  },
                )),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      productName,
                      style: kTextStyle16white.copyWith(
                          color: AppColors.whiteAndBlackColor, fontSize: 14.sp),
                    ),
                  ),
                  Row(
                    children: [
                      CustomEyeView(
                        color: AppColors.primaryProductive,
                        views: numberOfViews,
                      ),
                      const Spacer(),
                      RatingWidget(
                        startFirst: true,
                        rating: numberOfRating,
                        color: AppColors.primaryProductive,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomSvg(svg: AppSvg.delivery, width: 20),
                      const SizedBox(
                        width: 2,
                      ),
                      Text('$numberOfOrders ',
                          style: kTextStyle10WhiteAndBlack),
                      Text(
                        "homeProductive.order".tr(),
                        style: kTextStyle10WhiteAndBlack,
                      ),
                      const Spacer(),
                      CustomSvg(
                        svg: AppSvg.priceSolar,
                        color: AppColors.primaryProductive,
                        width: 20,
                      ),
                      Text("$recentPrice ", style: kTextStyle10WhiteAndBlack),
                      Text(
                        "sar".tr(),
                        style: kTextStyle10WhiteAndBlack,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  EditDetailsAndDeleteProductButtons(
                    onTap: onEdit,
                    productId: productId ?? 0,
                    color: AppColors.primaryProductive,
                    onDeleteProduct: onDeleteProduct,
                  ),
                  const SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
