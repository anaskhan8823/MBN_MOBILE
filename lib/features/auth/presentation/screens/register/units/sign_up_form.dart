import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:dalil_2020_app/features/widgets/custom_field_with_hint_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../core/app_assets.dart';
import '../../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../../core/shared/widgets/custom_field_text.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_size.dart';
import '../../../../../../core/style/text_style.dart';
import '../../../../../../core/validators/app_validators.dart';
import '../../../../../../models/error_model.dart';
import '../../../../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import '../../../../../widgets/build_location_section.dart';
import '../../../../../widgets/custom_pass_strength.dart';
import '../../../../data/enums/user_type_enum.dart';
import '../../../controllers/map_cubit.dart';
import '../../../widgets/map_widget.dart';
part 'package:dalil_2020_app/features/auth/presentation/screens/register/units/agree_terms.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.userTypeEnum});
  final UserTypeEnum userTypeEnum;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<AuthCubit, AuthStates>(builder: (_, state) {
        final cubit = AuthCubit.get(context);
        final locationCubit = context.read<LocationCubit>();
        final uploadCubit = context.read<UploadPhotoCubit>();
        return Form(
            key: cubit.formKey,
            child: Column(spacing: AppSize.getHeight(16), children: [
              CustomFieldWithHint(
                controller: TextEditingController(),
                hintText: userTypeEnum.title,
                iconStart: AppIcons.userType,
                readOnly: true,
                enabled: false,
              ),
              CustomFieldText(
                isRequired: true,
                labelText: 'sign_up.user_name',
                errorText: state is ErrorState
                    ? state.listOfError
                            .firstWhere((error) => error.field == 'name',
                                orElse: () => Errors())
                            .message ??
                        ''
                    : '',
                controller: cubit.userNameController,
                // hintText: 'sign_up.user_name',
                iconStart: AppIcons.user,
              ),
              CustomFieldText(
                isRequired: true,
                labelText: 'sign_up.email',
                errorText: state is ErrorState
                    ? state.listOfError
                            .firstWhere((error) => error.field == 'email',
                                orElse: () => Errors())
                            .message ??
                        ''
                    : '',
                controller: cubit.emailController,
                // hintText: 'sign_up.email',
                iconStart: AppIcons.email,
              ),
              buildLocationSection(
                locationCubit,
                context,
                cubit,
                state is ErrorState
                    ? state.listOfError
                            .firstWhere((error) => error.field == 'phone',
                                orElse: () => Errors())
                            .message ??
                        ''
                    : '',
                state is ErrorState
                    ? state.listOfError
                            .firstWhere((error) => error.field == 'address',
                                orElse: () => Errors())
                            .message ??
                        ''
                    : '',
              ),
              PasswordStrengthWidget(
                isRequired: true,
                label: 'sign_up.password',
                validator: (val) => AppValidators.passwordStrong(val),
                errorText: state is ErrorState
                    ? state.listOfError
                            .firstWhere((error) => error.field == 'password',
                                orElse: () => Errors())
                            .message ??
                        ''
                    : '',
                cubit: context.read<AuthCubit>(),
                checkStrength: true,
                controller: cubit.passwordController,
              ),
              Text(
                context.tr("change.strong_password"),
                style: TextStyle(
                    color: AppColors.textLabelUnSelected, fontSize: 13.sp),
              ),
              PasswordStrengthWidget(
                isRequired: true,
                label: 'sign_up.confirm_password',
                errorText: state is ErrorState
                    ? state.listOfError
                            .firstWhere((error) => error.field == 'password',
                                orElse: () => Errors())
                            .message ??
                        ''
                    : '',
                cubit: context.read<AuthCubit>(),
                controller: cubit.passwordConfirmController,
                // hintText: context.tr('signz_up.confirm_password'),
              ),
              if (userTypeEnum == UserTypeEnum.representative) ...{
                GestureDetector(
                  onTap: () {
                    // showModalBottomSheet(
                    //   context: context,
                    //   isScrollControlled: true,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius:
                    //         BorderRadius.vertical(top: Radius.circular(20)),
                    //   ),
                    //   builder: (context) {
                    //     return SizedBox(
                    //       height: MediaQuery.of(context).size.height * 0.85,
                    //       child: const MapWidget(),
                    //     );
                    //   },
                    // );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(),
                    child: Text(
                      "Get Location",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              },
              const AgreeTermsWidget(),
              CustomButton(
                onTap: () {
                  print(
                      "Final location before signup: ${context.read<MapCubit>().state.location}");

                  cubit.signUp(
                      locationCubit.countryId ?? 0,
                      locationCubit.cityId ?? 0,
                      locationCubit.selectedValue ?? '',
                      uploadCubit.profileImage,
                      userTypeEnum.key,
                      context.read<MapCubit>().state.location);
                },
                loading: state is LoadingAuthState,
                title: context.tr('sign_up.create_account'),
              ),
            ]));
      }),
    ]);
  }
}
