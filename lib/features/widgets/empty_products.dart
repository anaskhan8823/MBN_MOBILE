import 'package:dalil_2020_app/features/main/add_product/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helper/app_navigator.dart';
import '../../core/shared/widgets/custom_button.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_size.dart';
class EmptyProducts extends StatelessWidget {
  const EmptyProducts({
    super.key, required this.enterUser,  this.storeId, required this.editOrAdd,this.color
  });
  final String enterUser;
  final int ?storeId;
  final String editOrAdd;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("addStore.emptyProducts".tr(),
            style: TextStyle(color: AppColors.whiteAndBlackColor),
            textAlign: TextAlign.center,
          ),
          CustomButton(
            bgColor: color??AppColors.primary,
            textSize: 12.sp,
            title: "addStore.newProduct",
            textColor:AppColors.blackAndWhiteColor ,
            width: AppSize.getWidth(200),
            onTap: () => AppNavigator.push(AddProduct(enterScreen: enterUser, storeId: storeId,)),
          )
        ],
      ),
    );
  }
}
