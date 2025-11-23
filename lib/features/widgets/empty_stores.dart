import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/helper/app_navigator.dart';
import '../../core/shared/widgets/custom_button.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_size.dart';
import '../main/shop_owner_details/add_store/nav_and_stepper_add_store.dart';
class EmptyStores extends StatelessWidget {
  const EmptyStores({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child:  Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("addStore.emptyStores".tr(),
            style: TextStyle(color: AppColors.whiteAndBlackColor),
            textAlign: TextAlign.center,
          ),
          CustomButton(
            textSize: 12.sp,
            title: "addStore.newStore",
            textColor:AppColors.blackAndWhiteColor ,
            width: AppSize.getWidth(200),
            onTap: () => AppNavigator.push(const NavAddStore()),
          )
        ],
      ),
    );
  }
}
