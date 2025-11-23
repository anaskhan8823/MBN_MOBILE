import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_assets.dart';
import '../../../core/shared/widgets/auth_appbar.dart';
import '../../../core/style/app_size.dart';
import '../../../core/style/text_style.dart';
import '../../auth/presentation/city_and_country/city_drop_button_provider.dart';
import '../../auth/presentation/city_and_country/code_and_country_provider.dart';
import '../../auth/presentation/city_and_country/cubit/location_cubit.dart';
import '../../auth/presentation/screens/register/units/upload_photo_card.dart';
import '../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import '../../widgets/custom_field_with_hint_text.dart';
import '../../widgets/helper_label_text_for_field.dart';
import '../controllers/my_account_cubit.dart';

class EditMyProfile extends StatelessWidget {
  const EditMyProfile({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MyAccountCubit(),
        ),
        BlocProvider(
          create: (context) => UploadPhotoCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        appBar: AuthAppbar(
          title: "myProfile.editProfile",
          showLang: false,
          color: color ?? AppColors.primary,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: BlocBuilder<MyAccountCubit, MyAccountState>(
              builder: (context, state) {
            final cubit = context.read<MyAccountCubit>();
            final locationCubit = context.read<LocationCubit>();
            final uploadCubit = context.read<UploadPhotoCubit>();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.getHeight(32),
                  ),
                  Center(
                      child: UploadPhotoCard(
                    color: color,
                  )),
                  SizedBox(
                    height: AppSize.getHeight(12),
                  ),
                  Center(
                    child: Text(CachHelper.userName ?? 'sign_up.user_name'.tr(),
                        style: kTextStyle16Orange.copyWith(
                            color: color ?? AppColors.primary)),
                  ),
                  SizedBox(
                    height: AppSize.getHeight(8),
                  ),
                  const HelperLabelTextForFiled(
                    label: 'sign_up.user_name',
                  ),
                  CustomFieldWithHint(
                    controller: cubit.userNameController,
                    hintText: CachHelper.userName ?? 'sign_up.user_name'.tr(),
                    iconStart: AppIcons.user,
                    iconColor: color ?? AppColors.primary,
                  ),
                  SizedBox(
                    height: AppSize.getHeight(15),
                  ),
                  const HelperLabelTextForFiled(
                    label: 'sign_up.email',
                  ),
                  CustomFieldWithHint(
                    controller: cubit.emailController,
                    hintText: CachHelper.email ?? 'sign_up.email'.tr(),
                    iconStart: AppIcons.email,
                    iconColor: color ?? AppColors.primary,
                  ),
                  SizedBox(
                    height: AppSize.getHeight(15),
                  ),
                  BlocBuilder<LocationCubit, LocationState>(
                      builder: (_, state) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: HelperLabelTextForFiled(
                              label: 'sign_up.phone',
                            ),
                          ),
                          CustomFieldWithHint(
                            iconColor: color ?? AppColors.primary,
                            icon: CodeAndCountryDropButton(
                              dialCode: CachHelper.countryCode,
                              values: locationCubit.selectedValue,
                              onChange: (value) {
                                locationCubit.changeCountryOnly(value);
                              },
                              value: 0,
                              label: '',
                            ),
                            keyboardType: TextInputType.number,
                            controller: cubit.phoneController,
                            hintText:
                                CachHelper.phoneNumber ?? 'sign_up.phone'.tr(),
                            iconStart: AppIcons.phone,
                          ),
                          SizedBox(
                            height: AppSize.getHeight(15),
                          ),
                          const HelperLabelTextForFiled(
                            label: 'sign_up.country',
                          ),
                          CodeAndCountryDropButton(
                            color: color ?? AppColors.primary,
                            padding: const EdgeInsets.only(right: 12),
                            value: locationCubit.countryId ?? 0,
                            onChanged: (int? value) {
                              locationCubit.changeCountry(
                                locationCubit.selectedValue,
                                value,
                              );
                              locationCubit.clearCitySelection();
                            },
                            codeAndNameOfCountry: false,
                            label: CachHelper.country ??
                                context.tr('sign_up.country'),
                          ),
                          SizedBox(
                            height: AppSize.getHeight(15),
                          ),
                          const HelperLabelTextForFiled(
                            label: 'sign_up.city',
                          ),
                          CityAndCountryDropButton(
                            label:
                                CachHelper.city ?? context.tr('sign_up.city'),
                            padding: const EdgeInsets.only(right: 12),
                            value: locationCubit.cityId,
                            onChanged: (int? value) {
                              locationCubit.changeCityAndId(
                                  locationCubit.selectedCity, value!);
                            },
                            cubit: locationCubit,
                            color: color ?? AppColors.primary,
                          ),
                        ]);
                  }),
                  SizedBox(
                    height: AppSize.getHeight(15),
                  ),
                  const HelperLabelTextForFiled(
                    label: 'sign_up.address',
                  ),
                  CustomFieldWithHint(
                    iconColor: color ?? AppColors.primary,
                    controller: cubit.addressController,
                    hintText: CachHelper.address ?? 'sign_up.address'.tr(),
                    iconStart: AppIcons.location,
                  ),
                  SizedBox(
                    height: AppSize.getHeight(20),
                  ),
                  CustomButton(
                    bgColor: color ?? AppColors.primary,
                    title: 'myProfile.save'.tr(),
                    onTap: () {
                      cubit.editProfile(
                          locationCubit.countryId,
                          locationCubit.cityId,
                          uploadCubit.profileImage,
                          locationCubit.selectedValue);
                    },
                    loading: state is MyAccountLoading,
                  ),
                  SizedBox(
                    height: AppSize.getHeight(20),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
