import 'package:dalil_2020_app/core/validators/app_validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../features/auth/presentation/city_and_country/code_and_country_provider.dart';
import '../../app_assets.dart';
import '../../../../../core/shared/widgets/custom_field_text.dart';
class CustomPhoneField extends StatelessWidget {
   const CustomPhoneField({super.key,
    this.controller, this.onChange, this.value,required this.errText,  this.isRequired=false});
  final TextEditingController ?controller;
  final void Function(String?)? onChange;
  final String? value;
  final String ?errText;
 final  bool isRequired;
  get state => null;
  @override
  Widget build(BuildContext context) {
        return
          CustomFieldText(
            validator:(value) => AppValidators.required(value) ,
             isRequired:isRequired ,
                icon:
            CodeAndCountryDropButton(
            values: value,
            onChange: onChange, value: 0, label: '',
              ),
          errorText: errText,
          keyboardType: TextInputType.number,
          controller: controller,
          labelText:'sign_up.phone'.tr(),
          iconStart: AppIcons.phone,

        );
  }
}




