import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/verify_cubit.dart';
import 'package:easy_localization/easy_localization.dart' as lang;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../../core/shared/widgets/container_with_background_image.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_size.dart';
import '../../../data/repo/auth_repo_impel.dart';
class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.phone, required this.dialCode});
final String phone;
final String dialCode;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyCubit(AthRepoImpel(),
        dialCode: dialCode,
        phoneNumber: phone,
          ),
      child: Scaffold(
          resizeToAvoidBottomInset: true,
        body: ContainerWithBackgroundImage(
          image: AppColors.isDark()?AppImages.backgroundDarkNoSpace:AppImages.backgroundLightNoSpace,
          child: SingleChildScrollView(
            child: BlocBuilder<VerifyCubit,VerifyStates>(
              builder:(context, state) {
                bool hasError = state is ErrorVerifyState;
                final cubit =context.read<VerifyCubit>();
                return SingleChildScrollView(
                  child: Column(
                      children: [
                        const AuthAppbar(
                          title: "otp.enter_your_otp",
                          showLang: false,
                        ),
                        SizedBox(height: AppSize.getHeight(38)),
                        CustomSvg(
                          svg: AppIcons.otp,
                        ),
                        SizedBox(height: AppSize.getHeight(24)),
                        Text(
                context.tr("forget_password.enter_your_phone"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppSize.font(14),
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppSize.getHeight(24)),
                  
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            length: 4,

                            onCompleted:(value) {

                            } ,
                            appContext: context,
                            onChanged: (value) {
                              cubit.otp=value;
                            },
                            // validator: (value) => AppValidators.otp(value),
                            pinTheme: PinTheme(

                              borderWidth: 1,
                              shape: PinCodeFieldShape.box,
                              fieldWidth: AppSize.getSize(48),
                              selectedColor: AppColors.primary,
                              fieldHeight: AppSize.getSize(48),
                              fieldOuterPadding: EdgeInsets.zero,
                              inactiveColor: AppColors.primary,
                              activeFillColor: hasError ? Colors.red : AppColors.primary,
                              activeColor: hasError ? Colors.red : AppColors.primary,
                              inactiveFillColor: AppColors.primary,
                              selectedFillColor: AppColors.primary,
                              borderRadius: BorderRadius.circular(
                                  AppSize.getSize(12)),
                            ),
                            cursorColor: AppColors.primary,
                            controller: cubit.otpController,
                            beforeTextPaste: (text) => true,
                            animationType: AnimationType.fade,
                            keyboardType: TextInputType.number,
                            backgroundColor: Colors.transparent,
                            errorTextSpace: AppSize.getHeight(20),
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            animationDuration: const Duration(milliseconds: 300),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                            context.tr( "otp.didn't_receive"),
                                style: kTextStyle14white
                              ),
                  
                              TextButton(
                                onPressed: () {
                                  cubit.resendCode();
                                },
                                child: Text(
                                    context.tr( "otp.resend"),
                                  style: TextStyle(
                                    decorationColor:  AppColors.primary,
                                    fontSize: AppSize.font(14),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                  
                              ),
                  
                              SizedBox(height: AppSize.getHeight(48)),
                            ]),
                        CustomButton(
                          loading: state is VerifyLoading,
                            title:context.tr( "otp.verify"),
                            onTap: () {
                              cubit.verifyCode();
                            }
                        ),

                      ]
                  ),
                );
              })
           )
  )
  )
  );

  }

}
