import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_assets.dart';
import '../../../../auth/presentation/city_and_country/city_drop_button_provider.dart';
import '../../../../auth/presentation/city_and_country/code_and_country_provider.dart';
import '../../../../auth/presentation/city_and_country/cubit/location_cubit.dart';
import '../../../../widgets/custom_field_with_hint_text.dart';
import '../../../controller/stepper_and_add_product_cubit.dart';
import '../../../controller/store_and_product_cubit/add_store_cubit.dart';

class EditContactStore extends StatelessWidget {
  const EditContactStore(
      {super.key,
      this.city,
      this.phoneNumber,
      this.country,
      this.dialCode,
      this.address});
  final String? city;
  final String? phoneNumber;
  final String? country;
  final String? address;
  final String? dialCode;
  @override
  Widget build(BuildContext context) {
    final key = context.read<StepperAndNavAddProductCubit>().formKey;
    return Form(
      key: key,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            spacing: 19,
            children: [
              BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
                builder: (context, addState) {
                  final addCubit = context.read<StoreAndProductCubit>();
                  return BlocBuilder<LocationCubit, LocationState>(
                    builder: (_, state) {
                      final cubit = context.read<LocationCubit>();
                      return Column(
                        spacing: 15,
                        children: [
                          CodeAndCountryDropButton(
                            padding: const EdgeInsets.only(right: 12),
                            value: cubit.countryId ?? 0,
                            onChanged: null,
                            // (int? value) {
                            //   cubit.changeCountry(
                            //     cubit.selectedValue,
                            //     value,
                            //   );
                            //   cubit.clearCitySelection();
                            // },
                            codeAndNameOfCountry: false,
                            label: country ?? context.tr('sign_up.country'),
                          ),
                          CityAndCountryDropButton(
                            label: city ??
                                cubit.selectedCity ??
                                context.tr('sign_up.city'),
                            padding: const EdgeInsets.only(right: 12),
                            value: cubit.cityId,
                            onChanged: null,
                            // (int? value) {
                            //   cubit.changeCityAndId(cubit.selectedCity, value!);
                            // },
                            cubit: cubit,
                          ),
                          CustomFieldWithHint(
                            hintText: address ?? context.tr('sign_up.address'),
                            controller: addCubit.address,
                            iconStart: AppIcons.location,
                            readOnly: true,
                          ),
                          CustomFieldWithHint(
                            readOnly: true,
                            icon: CodeAndCountryDropButton(
                              dialCode: dialCode,
                              values: cubit.selectedValue,
                              onChange: null,
                              // (value) {
                              //   cubit.changeCountryOnly(value);
                              // },
                              value: 0,
                              label: '',
                            ),
                            keyboardType: TextInputType.number,
                            controller: addCubit.phoneNumber,
                            hintText: phoneNumber ?? 'sign_up.phone'.tr(),
                            iconStart: AppIcons.phone,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Image.asset(AppImages.mapOfUser)
            ],
          ),
        ),
      ),
    );
  }
}
