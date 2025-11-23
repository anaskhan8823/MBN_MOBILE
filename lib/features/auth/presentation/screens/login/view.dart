import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/container_with_background_image.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/shared/widgets/app_logo_with_name.dart';
import '../../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../../core/shared/widgets/custom_phone_field.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../models/error_model.dart';
import '../../../../widgets/custom_pass_strength.dart';
import '../../../data/repo/auth_repo_impel.dart';
import '../../city_and_country/cubit/location_cubit.dart';
import '../../widgets/auth_or_separator.dart';
import '../../widgets/custom_floating_button.dart';
import '../forget_password/view.dart';
import '../select_account_type/view.dart';
import 'units/login_methods.dart';
part 'package:dalil_2020_app/features/auth/presentation/screens/login/units/donnt_have_account.dart';
part 'package:dalil_2020_app/features/auth/presentation/screens/login/units/forget_password.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthCubit(AthRepoImpel()),
            ),
            BlocProvider(
              create: (context) => LocationCubit(),
            ),
          ],
          child: ContainerWithBackgroundImage(
            child: SingleChildScrollView(
              child:
                  BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
                final cubit = AuthCubit.get(context);
                final locationCubit = context.read<LocationCubit>();
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      const AuthAppbar(),
                      const AppLogoWithName(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04),
                      Text(context.tr("login.welcome"),
                          style: kTextStyle16white.copyWith(
                              fontSize: AppSize.getSize(21))),
                      SizedBox(height: AppSize.getHeight(20)),
                      BlocBuilder<LocationCubit, LocationState>(
                        builder: (context, locationState) {
                          return CustomPhoneField(
                            errText: state is ErrorState
                                ? state.listOfError
                                        .firstWhere(
                                            (error) => error.field == 'phone',
                                            orElse: () => Errors())
                                        .message ??
                                    ''
                                : '',
                            value: locationCubit.selectedValue,
                            onChange: (value) {
                              locationCubit.changeCountryOnly(value);
                            },
                            controller: cubit.phoneController,
                          );
                        },
                      ),
                      SizedBox(height: AppSize.getHeight(16)),
                      PasswordStrengthWidget(
                        isRequired: false,
                        errorText: state is ErrorState
                            ? state.listOfError
                                    .firstWhere(
                                        (error) => error.field == 'password',
                                        orElse: () => Errors())
                                    .message ??
                                ''
                            : '',
                        cubit: context.read<AuthCubit>(),
                        controller: cubit.passwordController,
                        label: 'login.password',
                      ),
                      SizedBox(height: AppSize.getHeight(10)),
                      const ForgetPassword(),
                      SizedBox(height: AppSize.getHeight(25)),
                      CustomButton(
                        loading: state is LoadingAuthState,
                        title: context.tr("login.login"),
                        onTap: () {
                          cubit.signIn(
                            locationCubit.selectedValue ?? '',
                          );
                        },
                      ),
                      SizedBox(height: AppSize.getHeight(8)),
                      const NotHaveAccount(),
                      SizedBox(height: AppSize.getHeight(8)),
                      ContinueWithoutLogin(),
                      SizedBox(height: AppSize.getHeight(60)),
                      const AuthOrSeparator(),
                      SizedBox(height: AppSize.getHeight(16)),
                      const LoginMethods(),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        floatingActionButton: CustomFloatingButton());
  }
}
