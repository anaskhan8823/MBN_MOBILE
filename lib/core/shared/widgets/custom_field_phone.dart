import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:flutter_intl_phone_field/countries.dart';

import '../../validators/app_validators.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';

class CustomFieldPhone extends StatelessWidget {
  const CustomFieldPhone({
    super.key,
    this.title,
    this.selectedPhone,
    this.onPhoneChanged,
    this.selectedCountry,
    this.onCountryChanged,
    required this.controller,
  });

  final String? title;
  final Country? selectedCountry;
  final PhoneNumber? selectedPhone;
  final TextEditingController controller;
  final Function(Country)? onCountryChanged;
  final Function(PhoneNumber)? onPhoneChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(
              fontSize: AppSize.font(14),
              fontWeight: FontWeight.w700,
              color: AppColors.typographyHeading,
            ),
          ),
          SizedBox(height: AppSize.getHeight(6)),
        ],
        IntlPhoneField(
          autofocus: true,
          countries: [
            Country(
              flag: '🇸🇦',
              code: 'SA',
              minLength: 9,
              maxLength: 9,
              dialCode: '966',
              name: 'Saudi Arabia',
              nameTranslations: {
                'en': 'Saudi Arabia',
                'ar': 'المملكة العربية السعودية',
              },
            ),
          ],
          dialogType: DialogType.showModalBottomSheet,
          style: TextStyle(
            fontSize: AppSize.font(14),
            fontWeight: FontWeight.w600,
          ),
          pickerDialogStyle: PickerDialogStyle(
            countryNameStyle: TextStyle(
              fontSize: AppSize.font(14),
              fontWeight: FontWeight.w500,
            ),
            countryCodeStyle: TextStyle(
              fontSize: AppSize.font(14),
              fontWeight: FontWeight.w500,
            ),
            listTilePadding: EdgeInsets.zero,
            listTileDivider: SizedBox(),
            searchFieldPadding: EdgeInsets.zero,
          ),
          controller: controller,
          showCountryFlag: false,
          dropdownIcon: Icon(Icons.keyboard_arrow_down),
          initialCountryCode: 'SA',
          onChanged: onPhoneChanged,
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: AppSize.getSize(12),
              horizontal: AppSize.getSize(16),
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: AppSize.getHeight(40),
              maxHeight: AppSize.getHeight(40),
            ),
            prefixIconConstraints: BoxConstraints(
              minHeight: AppSize.getHeight(40),
              maxHeight: AppSize.getHeight(40),
            ),
          ),
          dropdownTextStyle: TextStyle(
            fontSize: AppSize.font(14),
            fontWeight: FontWeight.w600,
          ),
          onCountryChanged: onCountryChanged,
          textInputAction: TextInputAction.next,
          dropdownDecoration: BoxDecoration(
            border: BorderDirectional(
              end: BorderSide(color: AppColors.inputOutline),
            ),
          ),
          flagsButtonMargin: EdgeInsets.only(
          ),
          validator: (v) => AppValidators.exactLength(
            v?.number,
            selectedCountry?.maxLength ?? 9,
          ),
        ),
      ],
    );
  }
}
