import 'package:flutter/material.dart';
import 'package:dalil_2020_app/features/auth/data/repo/auth_repo_impel.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/verify_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../../core/shared/widgets/custom_button.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../../models/error_model.dart';
import '../../widgets/custom_pass_strength.dart';
class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key,this.color
    });
  final Color?color;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyCubit(AthRepoImpel(),
          phoneNumber: '', dialCode: ''
      ),
      child: Scaffold(
        appBar:  AuthAppbar(
          color: color,
      title: "reset_password.reset_password",
    showLang: false,),

    resizeToAvoidBottomInset: true,
        body: BlocBuilder<VerifyCubit, VerifyStates>(
          builder: (context, state) {
            final cubit =context.read<VerifyCubit>();
            return Form(
              key: cubit.formKey,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  spacing: 20,
                  children: [
                    Text(
                        context.tr("change.fill"),
                        textAlign: TextAlign.center,
                        style:kTextStyle14white.copyWith(fontSize: 10,fontWeight: FontWeight.w500)
                    ),
                    PasswordStrengthWidget(
                      color: color,
                      isRequired: true,
                      label: "change.old",
                      errorText: state is ErrorVerifyState ? state.listOfError.firstWhere((error) => error.field == 'current_password', orElse: () => Errors()).message ?? '' : '',
                      cubit:context.read<VerifyCubit>(),
                      controller: cubit.oldPasswordController,
                    ),
                    PasswordStrengthWidget(
                      color: color,
                      isRequired: true,
                      label:  "reset_password.new_password",
                      errorText: state is ErrorVerifyState
                          ? state.listOfError
                          .firstWhere(
                              (error) => error.field == 'new_password', orElse: () => Errors()).message ?? '' : '',
                      cubit:context.read<VerifyCubit>(),
                      controller: cubit.passwordController,
                      checkStrength: true,
                    ),
                    PasswordStrengthWidget(
                      color: color,
                      isRequired: true,
                      label: "reset_password.confirm_new_password",
                      errorText: state is ErrorVerifyState ? state.listOfError.firstWhere((error) => error.field == 'password_confirmation', orElse: () => Errors()).message ?? '' : '',
                      cubit:context.read<VerifyCubit>(),
                      controller: cubit.passwordConfirmationController,
                    ),
                    SizedBox(height: AppSize.getHeight(30)),
                    CustomButton(
                      bgColor: color,
                      loading:  state is VerifyLoading,
                      title:context.tr( "change.changePass"),
                      onTap: () {
                         cubit.changePassword();
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
