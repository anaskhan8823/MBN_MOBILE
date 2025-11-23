import 'package:dalil_2020_app/features/widgets/product_card_for_shop_owner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/style/app_size.dart';

class CustomProductLoading extends StatelessWidget {
  const CustomProductLoading({
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
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        scrollDirection: scrollDirection ?? Axis.vertical,
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount ?? 2,
            childAspectRatio: childAspectRatio ?? 0.50),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppSize.getHeight(8),
                horizontal: AppSize.getWidth(8)),
            child: ProductCardForShopOwner(
              storeId: 0,
              onDeleteProduct: () {},
              saleType: '',
              category: '',
              productImage: '',
              productId: 0,
              recentPrice: "0",
              productName: "skin care",
              oldPrice: "0",
            ),
          );
        });
  }
}
