import 'package:dalil_2020_app/core/validators/app_validators.dart';
import 'package:dalil_2020_app/features/main/controller/stepper_and_add_product_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_field_text.dart';
import '../../core/style/app_colors.dart';

class FormOfStoreAndProducts extends StatelessWidget {
  const FormOfStoreAndProducts({
    super.key,
    required this.cubit,
    required this.isStore,
    this.color,
  });

  final StoreAndProductCubit cubit;
  final bool isStore;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final key = context.read<StepperAndNavAddProductCubit>().formKey;
    return Form(
      key: key,
      child: Column(
        spacing: 16,
        children: [
          CustomFieldText(
            validator: (value) => AppValidators.required(value),
            controller: cubit.arabicName,
            isRequired: true,
            errorText: '',
            labelText: isStore == true
                ? 'addStore.arabicName'
                : 'addProduct.arabicName',
            iconStart: AppSvg.store,
            iconColor: color,
          ),
          CustomFieldText(
              validator: (value) => AppValidators.required(value),
              iconColor: color,
              controller: cubit.englishName,
              isRequired: true,
              errorText: '',
              labelText: isStore == true
                  ? 'addStore.englishName'
                  : 'addProduct.englishName',
              iconStart: AppSvg.store),
          TextFormField(
            validator: (value) => AppValidators.required(value),
            controller: cubit.arabicDisc,
            style: TextStyle(color: AppColors.whiteAndBlackColor),
            decoration: InputDecoration(
              label: Text(
                'addProduct.arabicDesc'.tr(),
                style: TextStyle(
                    fontSize: 12.sp, color: AppColors.labelInputColor),
              ),
            ),
            maxLines: 5,
            maxLength: 500,
            minLines: 5,
          ),
          TextFormField(
            validator: (value) => AppValidators.required(value),
            controller: cubit.englishDisc,
            style: TextStyle(color: AppColors.whiteAndBlackColor),
            decoration: InputDecoration(
              label: Text(
                'addProduct.englishDesc'.tr(),
                style: TextStyle(
                    fontSize: 12.sp, color: AppColors.labelInputColor),
              ),
            ),
            maxLines: 5,
            maxLength: 500,
            minLines: 5,
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
