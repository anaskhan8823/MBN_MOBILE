import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_field_text.dart';
import '../../core/shared/widgets/custom_phone_field.dart';
import '../auth/presentation/city_and_country/city_drop_button_provider.dart';
import '../auth/presentation/city_and_country/code_and_country_provider.dart';
import '../auth/presentation/city_and_country/cubit/location_cubit.dart';

Widget buildLocationSection(LocationCubit locationCubit, BuildContext context,
    cubit, error, addressError) {
  return BlocBuilder<LocationCubit, LocationState>(builder: (_, state) {
    return Column(spacing: 15, children: [
      CodeAndCountryDropButton(
        isauth: true,
        padding: const EdgeInsets.only(right: 12),
        value: locationCubit.countryId ?? 0,
        onChanged: (int? value) {
          locationCubit.changeCountry(
            locationCubit.selectedValue,
            value,
          );
          locationCubit.clearCitySelection();
          locationCubit.getCityAndId(value!); // important
        },
        codeAndNameOfCountry: false,
        label: context.tr('sign_up.country'),
      ),
      if (locationCubit.countryId != null && locationCubit.countryId != 0) ...[
        CityAndCountryDropButton(
          
          label: locationCubit.selectedCity ?? context.tr('sign_up.city'),
          padding: const EdgeInsets.only(right: 12),
          value: locationCubit.cityId,
          onChanged: (int? value) {
            final city =
                locationCubit.cityModel.firstWhere((e) => e.id == value);
            locationCubit.changeCityAndId(city.name, value!);
          },
          cubit: locationCubit,
        ),
      ],
      CustomFieldText(
        isRequired: true,
        errorText: addressError,
        controller: cubit.addressController,
        labelText: context.tr('sign_up.address'),
        iconStart: AppIcons.location,
        validator: (String? value) {},
      ),
      CustomPhoneField(
        errText: error,
        value: locationCubit.selectedValue,
        onChange: (value) {
          locationCubit.changeCountryOnly(value);
        },
        controller: cubit.phoneController,
      ),
    ]);
  });
}
