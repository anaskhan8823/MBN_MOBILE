import 'package:dalil_2020_app/features/auth/data/repo/auth_repo_impel.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/verify_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../../core/shared/widgets/container_with_background_image.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../../models/error_model.dart';
import '../../../../widgets/custom_pass_strength.dart';
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.phoneNumber, required this.resetToken, required this.dialCode});
final String phoneNumber;
final String resetToken;
final String dialCode;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCubit(AthRepoImpel(),
        phoneNumber: phoneNumber, dialCode: dialCode
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocBuilder<VerifyCubit, VerifyStates>(
          builder: (context, state) {
            final cubit =context.read<VerifyCubit>();
            return ContainerWithBackgroundImage(
              image: AppColors.isDark()?AppImages.backgroundDarkNoSpace:AppImages.backgroundLightNoSpace,
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    const AuthAppbar(
                      hideBackButton: true,
                      title: "reset_password.reset_password",
                      showLang: false,
                    ),
                    SizedBox(height: AppSize.getHeight(24)),
                    Text(
                      context.tr("reset_password.reset_password_desc"),
                      textAlign: TextAlign.center,
                      style:kTextStyle14white.copyWith(fontSize: 10,fontWeight: FontWeight.w500)
                    ),
                    SizedBox(height: AppSize.getHeight(32)),
                    PasswordStrengthWidget(
                      isRequired: true,
                      label:  "reset_password.new_password",
                      errorText: state is ErrorVerifyState
                    ? state.listOfError
                        .firstWhere(
                        (error) => error.field == 'password', orElse: () => Errors()).message ?? '' : '',
              cubit:context.read<VerifyCubit>(),
                      controller: cubit.passwordController,
                      checkStrength: true,
                    ),
                    SizedBox(height: AppSize.getHeight(40)),
                    PasswordStrengthWidget(
                      isRequired: true,
                      label: "reset_password.confirm_new_password",
                      errorText: state is ErrorVerifyState
                          ? state.listOfError
                          .firstWhere(
                              (error) => error.field == 'password', orElse: () => Errors()).message ?? '' : '',

                      cubit:context.read<VerifyCubit>(),
                      controller: cubit.passwordConfirmationController,
                    ),
                    SizedBox(height: AppSize.getHeight(53)),
                    CustomButton(
                      loading:  state is VerifyLoading,
                      title:context.tr( "reset_password.confirm_new_password"),
                      onTap: () {
                        cubit.resetPassword(resetToken);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
