import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/features/auth/data/params/change_password_params.dart';
import 'package:dalil_2020_app/features/auth/data/params/resend__code_params.dart';
import 'package:dalil_2020_app/features/auth/data/params/verif_code_param.dart';
import 'package:dalil_2020_app/features/auth/data/repo/auth_repo.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/reset_password/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/app_toast.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/utils.dart';
import '../../../../models/error_model.dart';
import '../../data/params/reset_password_params.dart';
import '../screens/login/view.dart';
part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyStates> {
  final AuthRepo repo;
  VerifyCubit(
    this.repo, {
    required this.dialCode,
    required this.phoneNumber,
  }) : super(VerifyInit());
  bool obscurePassword = true;
  bool obscureOldPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  void toggleOldPassword() {
    obscureOldPassword = !obscureOldPassword;
    emit(UpdateObscurePassword());
  }

  void toggleNewPassword() {
    obscureNewPassword = !obscureNewPassword;
    emit(UpdateObscurePassword());
  }

  void toggleConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(UpdateObscurePassword());
  }

  void updateObscurePassword() {
    obscurePassword = !obscurePassword;
    emit(UpdateObscurePassword());
  }

  double passStrength = 0.0;
  Color strengthColor = Colors.red;
  void checkPasswordStrength(String pass) {
    double strength = 0.0;
    if (pass.length >= 6) strength += 0.3;
    if (pass.length >= 8) strength += 1;
    if (RegExp(r'[A-Z]').hasMatch(pass)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(pass)) strength += 0.2;
    strength = strength.clamp(0.0, 1.0);
    passStrength = strength;
    if (strength < 0.3) {
      strengthColor = Colors.red;
    } else if (strength < 0.6) {
      strengthColor = AppColors.primary;
    } else {
      strengthColor = Colors.green;
    }
    emit(UpdateIndicator());
  }

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final bool passwordbool = false;
  final bool oldPasswordbool = false;
  final bool passwordConfirmationbool = false;
  final String phoneNumber;
  final String dialCode;
  final otpController = TextEditingController();
  String? otp;
  Future<void> verifyCode() async {
    emit(VerifyLoading());
    final param =
        VerifyCodeParam(otp: otp ?? '', phone: phoneNumber, dialCode: dialCode);
    final api = await repo.verifyCode(param);
    api.fold((failure) {
      if (failure.error.isEmpty) {
        String errMsg = "failure.unexpected_error".tr();
        AppToast.error(errMsg);
        emit(VerifyInit());
      } else if (failure.error[0].field == 'general') {
        AppToast.error(failure.error[0].message ?? "");
      }
      for (var error in failure.error) {}
      emit(ErrorVerifyState(listOfError: failure.error));
    }, (list) async {
      final resetToken = list.resetToken ?? '';
      AppToast.success("otp.success_request".tr());
      emit(VerifySuccess());
      AppNavigator.replace(ResetPasswordScreen(
        phoneNumber: phoneNumber,
        resetToken: resetToken,
        dialCode: dialCode,
      ));
    });
  }

  Future<void> resendCode() async {
    emit(VerifyLoading());
    final param = ResendCodeParam(phone: phoneNumber, dialCode: dialCode);
    final api = await repo.resendCode(param);
    api.fold((failure) {
      if (failure.error.isEmpty) {
        String errMsg = "failure.unexpected_error".tr();
        AppToast.error(errMsg);
        emit(VerifyInit());
      } else if (failure.error[0].field == 'general') {
        AppToast.error(failure.error[0].message ?? "");
      }
      for (var error in failure.error) {}
      emit(ErrorVerifyState(listOfError: failure.error));
    }, (r) async {
      emit(VerifyInit());
      AppToast.success('otp.success_resend'.tr());
    });
  }

  Future<void> resetPassword(String resetToken) async {
    if (formKey.currentState!.validate()) {
      emit(VerifyLoading());
      final param = ResetPasswordParam(
        phoneNumber: phoneNumber,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
        resetToken: resetToken,
        dialCode: dialCode,
      );
      final api = await repo.resetPassword(param);
      api.fold((failure) {
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
          emit(VerifyInit());
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
        for (var error in failure.error) {}
        emit(ErrorVerifyState(listOfError: failure.error));
      }, (r) async {
        AppToast.success('reset_password.reset_password_success');
        emit(VerifyInit());
        AppNavigator.push(const SignInScreen());
      });
    }
  }

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (formKey.currentState!.validate()) {
      emit(VerifyLoading());
      final param = ChangePasswordParams(
        currentPass: oldPasswordController.text,
        newPass: passwordController.text,
        confirmPass: passwordConfirmationController.text,
      );
      final api = await repo.changePassword(param);
      api.fold((failure) {
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
          emit(VerifyInit());
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
        for (var error in failure.error) {}
        emit(ErrorVerifyState(listOfError: failure.error));
      }, (r) async {
        AppToast.success('reset_password.reset_password_success');
        emit(VerifyInit());
        AppNavigator.push(Utils.getUser);
      });
    }
  }
}
