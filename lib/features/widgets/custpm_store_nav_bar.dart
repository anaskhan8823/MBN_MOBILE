import 'package:flutter/material.dart';
import '../../core/shared/widgets/custom_button.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_size.dart';
class CustomStoreNavBar extends StatelessWidget {
  const CustomStoreNavBar({super.key, this.onBack,this.onNext, required this.index, this.color, this.addProductIndex});
  final void Function()? onNext;
  final void Function()? onBack;
  final int index;
  final int ?addProductIndex;
  final Color?color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
        bottom: AppSize.getHeight(13),right: AppSize.getWidth(28),left: AppSize.getWidth(28)),
      child: Row(
        spacing:  AppSize.getWidth(13),
        children: [
          Expanded(
            child: CustomButton(
              onTap:onBack ,
              title:"addStore.back",
              textColor:color?? AppColors.primary,
              bgColor: AppColors.blackAndWhiteColor,
              borderColor: color??AppColors.primary,
            ),
          ),
          Expanded(
            child: CustomButton(
              onTap: onNext ,
              title:index==3||addProductIndex==1?'addStore.confirm':"addStore.next",
              textColor: AppColors.blackAndWhiteColor,
              bgColor:color?? AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
