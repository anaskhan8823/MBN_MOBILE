import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_size.dart';
import '../../core/style/text_style.dart';
import 'custom_edit_and_delete_product_buttons.dart';

class ProductCardForUser extends StatelessWidget {
  const ProductCardForUser({
    super.key,
    required this.recentPrice,
    required this.oldPrice,
    this.category,
    this.saleType,
    required this.productName,
    required this.productId,
    required this.productImage,
    required this.storeId,
    this.onEdit,
    this.putEditAndDeleteButtons = false,
    this.onDeleteProduct,
  });
  final String recentPrice;
  final String oldPrice;
  final String productName;
  final String? category;
  final String? saleType;
  final int productId;
  final String productImage;
  final int storeId;
  final void Function()? onDeleteProduct;
  final void Function()? onEdit;
  final bool? putEditAndDeleteButtons;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 2, color: AppColors.primary),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        spacing: 10,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              productImage,
              height: MediaQuery.of(context).size.height * 0.12,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppImages.products,
                  height: MediaQuery.of(context).size.height * 0.12,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 08),
            child: Column(
              spacing: AppSize.getHeight(10),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: kTextStyle16white,
                ),
                Row(
                  children: [
                    Expanded(flex: 0, child: CustomSvg(svg: AppSvg.priceSolar)),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      flex: 0,
                      child:
                          Text(recentPrice, style: kTextStyle10WhiteAndBlack),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "sar".tr(),
                        style: kTextStyle10WhiteAndBlack.copyWith(fontSize: 8),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "addProduct.oldPrice".tr(),
                        style: TextStyle(
                            fontSize: AppSize.font(10),
                            color: AppColors.primary),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Text(" $oldPrice ",
                            style: kTextStyle9GreyLineThrough)),
                  ],
                ),
                if (putEditAndDeleteButtons == true) ...{
                  EditDetailsAndDeleteProductButtons(
                    onTap: onEdit ?? () {},
                    productId: productId,
                    color: null,
                    onDeleteProduct: onDeleteProduct ?? () {},
                  ),
                },
              ],
            ),
          )
        ],
      ),
    );
  }
}
