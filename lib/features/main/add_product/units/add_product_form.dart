import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/add_product/units/upload_product_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/form_of_store_and_products.dart';
import '../../controller/store_and_product_cubit/add_store_cubit.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (context, state) {
        final cubit = context.read<StoreAndProductCubit>();
        return Column(
          spacing: 15,
          children: [
            Expanded(
              flex: 0,
              child: Text(
                "addProduct.fill".tr(),
                style: TextStyle(
                    fontSize: 12, color: AppColors.whiteAndBlackColor),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                flex: 3,
                child: ListView(children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15.w),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      // height: MediaQuery.of(context).size.height*0.18,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color:color?? AppColors.primary,width: 2)
                      ),
                      child:  UploadProductImage(color: color,),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: FormOfStoreAndProducts(
                      cubit: cubit,
                      isStore: false,
                      color: color ?? AppColors.primary,
                    ),
                  )
                ])),
          ],
        );
      },
    );
  }
}
