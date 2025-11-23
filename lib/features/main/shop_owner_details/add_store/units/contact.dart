import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/validators/app_validators.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/map_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/shared/widgets/custom_field_text.dart';
import '../../../../../core/shared/widgets/custom_phone_field.dart';
import '../../../../auth/presentation/city_and_country/city_drop_button_provider.dart';
import '../../../../auth/presentation/city_and_country/code_and_country_provider.dart';
import '../../../../auth/presentation/city_and_country/cubit/location_cubit.dart';
import '../../../../auth/presentation/widgets/map_widget.dart';
import '../../../controller/stepper_and_add_product_cubit.dart';
import '../../../controller/store_and_product_cubit/add_store_cubit.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});
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
                            onChanged: (int? value) {
                              cubit.changeCountry(
                                cubit.selectedValue,
                                value,
                              );
                              addCubit.address.text =
                                  "${addCubit.city.text}, ${addCubit.country.text}";
                              cubit.clearCitySelection();
                            },
                            codeAndNameOfCountry: false,
                            label: context.tr('sign_up.country'),
                          ),
                          if (cubit.countryId != null &&
                              cubit.countryId != 0) ...[
                            CityAndCountryDropButton(
                              label: cubit.selectedCity ??
                                  context.tr('sign_up.city'),
                              padding: const EdgeInsets.only(right: 12),
                              value: cubit.cityId,
                              onChanged: (int? value) {
                                cubit.changeCityAndId(
                                  cubit.cityModel
                                      .firstWhere((c) => c.id == value)
                                      .name,
                                  value!,
                                );
                                addCubit.city.text =
                                    "${cubit.selectedCountry ?? ''}, ${cubit.selectedCity ?? ''}";

                                addCubit.address.text =
                                    "${addCubit.city.text},${addCubit.country.text}";
                              },
                              cubit: cubit,
                            ),
                          ],
                          GestureDetector(
                            // onTap: () {
                            //   context
                            //       .read<MapCubit>()
                            //       .getCoordinates(addCubit.address.toString());
                            //   final address = context
                            //       .read<StoreAndProductCubit>()
                            //       .address
                            //       .text;
                            //   if (address.isNotEmpty) {
                            //     context
                            //         .read<MapCubit>()
                            //         .getCoordinates(address);
                            //     print("Opening map for address: $address");
                            //   }

                            //   // final addressController = context
                            //   //     .read<StoreAndProductCubit>()
                            //   //     .address; // read outside
                            // },
                            child: CustomFieldText(
                              iconColor: AppColors.whiteAndOrangeColor,
                              isRequired: true,
                              errorText: '',
                              // icon: Icon(Icons.search),
                              controller: addCubit.address,
                              labelText: context.tr('sign_up.address'),
                              iconStart: AppIcons.location,
                              validator: (String? value) =>
                                  AppValidators.required(value),
                              onChanged: (val) {
                                // Optional: can debounce here if you want
                                context.read<MapCubit>().getCoordinates(val);
                              },
                            ),
                          ),
                          CustomPhoneField(
                            errText: '',
                            value: cubit.selectedValue,
                            onChange: (value) {
                              cubit.changeCountryOnly(value);
                              final address = addCubit.address.text;
                              if (address.isNotEmpty) {
                                context
                                    .read<MapCubit>()
                                    .getCoordinates(address);

                                print("address $address");
                              }
                            },
                            controller: addCubit.phoneNumber,
                          ),
                          SizedBox(
                            height: 300,
                            child: MapWidget(
                                searchController: context
                                    .read<StoreAndProductCubit>()
                                    .address),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  // GestureDetector(
                          //     onTap: () {
                          //       context
                          //           .read<MapCubit>()
                          //           .getCoordinates(addCubit.address.text);
                          //       print("address ${addCubit.address.text}");
                          //     },
                          //     child: Text("getlocation"))

  // GestureDetector(
              //   onTap: () {
              //     final address =
              //         context.read<StoreAndProductCubit>().address.text;
              //     if (address.isNotEmpty) {
              //       context.read<MapCubit>().getCoordinates(address);
              //       print("Opening map for address: $address");
              //     }

              //     final addressController = context
              //         .read<StoreAndProductCubit>()
              //         .address; // read outside

              //     showModalBottomSheet(
              //       context: context,
              //       isScrollControlled: true,
              //       shape: RoundedRectangleBorder(
              //         borderRadius:
              //             BorderRadius.vertical(top: Radius.circular(20)),
              //       ),
              //       builder: (context) {
              //         return SizedBox(
              //           height: MediaQuery.of(context).size.height * 0.85,
              //           child: BlocProvider(
              //             create: (_) => MapCubit()..getCurrentLocation(),
              //             child: MapWidget(searchController: addressController),
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //     decoration: BoxDecoration(
              //       color: AppColors.containerBackLight,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Text(
              //       "Get Location",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // )