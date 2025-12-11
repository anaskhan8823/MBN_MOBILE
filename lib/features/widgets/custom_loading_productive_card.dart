import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/app_assets.dart';
import '../../core/style/app_size.dart';
import 'card_product_productive_card.dart';

class ProductProductiveLoading extends StatelessWidget {
  const ProductProductiveLoading({
    super.key,
    required this.scrollDirection,
    required this.crossAxisCount,
    required this.childAspectRatio,
  });

  final Axis? scrollDirection;
  final int? crossAxisCount;
  final double? childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: GridView.builder(
            scrollDirection: scrollDirection ?? Axis.vertical,
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount ?? 2,
                childAspectRatio: childAspectRatio ?? 270.w / 480.h),
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppSize.getHeight(8),
                      horizontal: AppSize.getWidth(8)),
                  child: ProductProductiveCard(
                    onEdit: () {},
                    productId: 0,
                    onDeleteProduct: () {},
                    productImage: AppImages.wallet,
                    productName: "name",
                    recentPrice: "0",
                    numberOfOrders: 0,
                    numberOfRating: "0",
                    numberOfViews: 0,
                    price: '0',
                  ));
            }));
  }
}
