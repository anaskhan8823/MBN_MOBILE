import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/dialogs.dart';
import '../../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../../core/shared/widgets/container_with_background_image.dart';
import '../../../../../core/shared/widgets/custom_phone_field.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../../models/error_model.dart';
import '../../../data/repo/auth_repo_impel.dart';
import '../../city_and_country/cubit/location_cubit.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(AthRepoImpel()),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: ContainerWithBackgroundImage(
          child: SingleChildScrollView(
            child:
            BlocBuilder<AuthCubit, AuthStates>(builder: (context, state) {
              final cubit = AuthCubit.get(context);
              final locationCubit = context.read<LocationCubit>();
              return Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const Row(),
                    const AuthAppbar(
                      title: "forget_password.reset_password",
                      showLang: false,
                    ),
                    SizedBox(height: AppSize.getHeight(38)),
                    CustomSvg(
                      svg: AppIcons.reset,
                    ),
                    SizedBox(height: AppSize.getHeight(24)),
                    Text(context.tr("forget_password.enter_your_phone"),
                        textAlign: TextAlign.center, style: kTextStyle14white),
                    SizedBox(height: AppSize.getHeight(24)),
                    BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, locationState) {
                        return CustomPhoneField(
                          errText: state is ErrorState
                              ? state.listOfError
                              .firstWhere((error) => error.field == 'phone',
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
                    SizedBox(height: AppSize.getHeight(48)),
                    CustomButton(
                        loading: state is LoadingAuthState,
                        title: context.tr("forget_password.next"),
                        onTap: () {
                          displaySendCode(context,null);
                          cubit.forgetPassword(
                            locationCubit.selectedValue ?? '',
                          );
                        }),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
