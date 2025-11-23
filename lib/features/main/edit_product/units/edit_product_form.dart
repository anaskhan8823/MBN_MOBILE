import 'dart:io';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:dalil_2020_app/features/widgets/custom_field_with_hint_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/app_assets.dart';
import '../../controller/store_and_product_cubit/add_store_cubit.dart';
import 'edit_product_image.dart';

class EditProductForm extends StatelessWidget {
  const EditProductForm(
      {super.key,
      this.color,
      required this.arabicName,
      required this.englishName,
      required this.arabicDescription,
      required this.englishDescription,
      required this.initialImages});
  final Color? color;
  final String arabicName;
  final String englishName;
  final String arabicDescription;
  final List<File> initialImages;
  final String englishDescription;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (context, state) {
        final cubit = context.read<StoreAndProductCubit>();
        return BlocBuilder<ProductCubit, ProductState>(
            builder: (context, productState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 15,
              children: [
                Text(
                  "addProduct.fill".tr(),
                  style: TextStyle(
                      fontSize: 12, color: AppColors.whiteAndBlackColor),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.19,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: color ?? AppColors.primary, width: 2)),
                  child: EditProductImage(
                    initialImages: initialImages,
                    color: color,
                  ),
                ),
                CustomFieldWithHint(
                  controller: cubit.arabicName,
                  hintText: arabicName,
                  iconStart: AppSvg.store,
                  iconColor: color,
                ),
                CustomFieldWithHint(
                    iconColor: color,
                    controller: cubit.englishName,
                    hintText: englishName,
                    iconStart: AppSvg.store),
                TextField(
                  controller: cubit.arabicDisc,
                  style:  TextStyle(color: AppColors.whiteAndBlackColor),
                  decoration: InputDecoration(
                    hintText:arabicDescription,
              hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.labelInputColor)
                    // hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  maxLines: 5,
              maxLength: 500,
                ),
                TextField(
                  controller: cubit.englishDisc,
                  style:  TextStyle(color: AppColors.whiteAndBlackColor),
                  decoration: InputDecoration(
                      hintText:englishDescription,
                      hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.labelInputColor)
                    // hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  maxLines: 5,
                  maxLength: 500,
                  minLines: 5,
                ),
                const SizedBox(),
              ],
            ),
          );
        });
      },
    );
  }
}
