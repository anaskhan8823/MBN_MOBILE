import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_colors.dart';
import 'custom_service_container_product_details.dart';
class ServiceForShopOwnerInStoreDetails extends StatelessWidget {
  const ServiceForShopOwnerInStoreDetails({
    super.key, required this.category, required this.subCategory,  this.color,
  });
  final String category;
  final Color ?color;
  final String subCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
            child:
            CategoryButton(
                title:category,
                svg:CustomSvg(svg: AppSvg.handMadeProduct,height: 25.h,width: 30.w,
                  color:color?? AppColors.whiteAndOrangeColor,))),
        Expanded(
          child:CategoryButton(
              title:subCategory,
              svg:CustomSvg(svg: AppSvg.accessories, color:color?? AppColors.whiteAndOrangeColor,
              )),

        )],
    );
  }
}
