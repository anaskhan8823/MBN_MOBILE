import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_assets.dart';
import '../../core/helper/dialogs.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/app_size.dart';
import 'customOutlineButton.dart';
class EditAndDeleteButtons extends StatelessWidget {
  const EditAndDeleteButtons({
    super.key, this.color, this.onPressed,  this.storeId, required this.onDelete,
  });
  final Color?color;
 final  void Function()? onPressed;
 final int? storeId;
 final void Function() onDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSize.getWidth(10),
      children: [
        Expanded(
          child: CustomOutlinedButton(
            onPressed:onPressed,
              addIcon: true,
              icon: CustomSvg(
                svg: AppIcons.edit,
                height: 20,
                color:color?? Colors.orange,
              ),
              side: BorderSide(color:color??  AppColors.primary),
              backgroundColor: AppColors.transparent,
              labelColor: color?? Colors.orange,
              label: 'addProduct.edit'),
        ),
        Expanded(
          child: CustomOutlinedButton(
            onPressed: (){
              displayDeleteStoreSheet(context,color,onDelete);
            },
              addIcon: true,
              icon: CustomSvg(svg: AppSvg.deleteRounded, height: 20.h),
              side: const BorderSide(color: Colors.red),
              backgroundColor: AppColors.transparent,
              labelColor: Colors.red,
              label:color!=null?"addStore.deleteProduct".tr(): 'addProduct.deleteStore'.tr()),
        ),
      ],
    );
  }
}
