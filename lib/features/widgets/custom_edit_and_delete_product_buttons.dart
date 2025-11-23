import 'package:dalil_2020_app/core/helper/dialogs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_button.dart';
import '../../core/style/app_colors.dart';
class EditDetailsAndDeleteProductButtons extends StatelessWidget {
  const EditDetailsAndDeleteProductButtons({
    super.key,  required this.color, required this.onDeleteProduct, required this.productId, this.storeId, required this.onTap,
  });
  final Color? color;
  final void Function() onDeleteProduct;
  final void Function() onTap;
  final int productId;
  final int? storeId;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Expanded(
          flex:2,
          child: CustomButton(
            height: 40.h,
            bgColor:color==null?AppColors.primary:AppColors.primaryProductive,
            onTap:onTap ,
            title: "addProduct.edit".tr(),
            textSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: (){
              displayDeleteProductSheet(context,color,onDeleteProduct);
              },
            child: Image.asset(
              AppImages.deleteProduct,height: 40.h,
            ),
          ),
        )
      ],
    );
  }
}
