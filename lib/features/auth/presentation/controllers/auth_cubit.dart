import 'dart:developer';

import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/features/auth/data/enums/user_type_enum.dart';
import 'package:dalil_2020_app/features/auth/data/params/forget_password_params.dart';
import 'package:dalil_2020_app/features/auth/data/params/sign_up_param.dart';
import 'package:dalil_2020_app/features/auth/data/repo/auth_repo.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/otp/view.dart';
import 'package:dalil_2020_app/features/main/home/nav_shop_owner_view.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/helper/app_helper.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/helper/app_toast.dart';
import '../../../../core/style/app_colors.dart';
import '../../../delivery_user_view/bottom_navigation/presentation/view/bottom_navigation_for_delivery_user.dart';
import '../../../main/home/nav_productive_families_view.dart';
import '../../../main/home/nav_user_view.dart';
import '../../data/params/sign_in_param.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.repo) : super(AuthInitial());
  AuthRepo repo;
  static AuthCubit get(context) => BlocProvider.of(context);

  ///Obscure password
  bool obscurePassword = true;
  void updateObscurePassword() {
    obscurePassword = !obscurePassword;
    emit(AuthInitial());
  }

  ///check strength of password
  double passStrength = 0.0;
  Color strengthColor = Colors.red;
  void checkPasswordStrength(String pass) {
    double strength = 0.0;
    // if (pass.length >= 6) strength += 0.3;
    if (pass.length >= 8) strength += .3;
    if (RegExp(r'[A-Z]').hasMatch(pass)) strength += 0.2;
    if (RegExp(r'[a-z]').hasMatch(pass)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(pass)) strength += 0.2;
    if (RegExp(r'[@#$!|<>=+-]').hasMatch(pass)) strength += 0.1;
    strength = strength.clamp(0.0, 1.0);
    passStrength = strength;
    print('strength:$strength');
    if (strength < 0.3) {
      strengthColor = Colors.red;
    } else if (strength < 0.6) {
      strengthColor = AppColors.primary;
    } else {
      strengthColor = Colors.green;
    }
    emit(UpdateIndicator());
  }

  ///Agree to Our Terms
  bool isAgreedToTerms = false;
  void agreeToTerms() {
    emit(AgreeToTermsInit());
    isAgreedToTerms = !isAgreedToTerms;
    emit(AgreeToTermsSuccess());
  }

  /// Sign in Controllers
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  /// Sign Up controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  ///change user type
  String? userType;
  Future<void> changeUserType(String userEnum) async {
    userType = userEnum;
    emit(ChangeUerTypeState());
  }

  Future<void> signIn(String selectedValue) async {
    await AppHelper.closeKeyboard();
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (formKey.currentState!.validate()) {
      emit(LoadingAuthState());
      final param = SignInParam(
        phoneNumber: phoneController.text,
        password: passwordController.text,
        dialCode: selectedValue,
      );
      final api = await repo.signIn(param);
      api.fold(
        (failure) {
          if (failure.error.isEmpty) {
            String errMsg = "failure.unexpected_error".tr();
            AppToast.error(errMsg);
            emit(AuthInitial());
          } else if (failure.error[0].field == 'general') {
            AppToast.error(failure.error[0].message ?? "");
          }
          emit(ErrorState(listOfError: failure.error));
        },
        (r) {
          emit(Success());
          AppToast.success("login.done");
          if (CachHelper.role == UserTypeEnum.shopOwner.key) {
            AppNavigator.remove(const NavShopOwnerView());
          } else if (CachHelper.role == UserTypeEnum.productiveFamilies.key) {
            AppNavigator.remove(const NavProductiveView());
          } else if (CachHelper.role == UserTypeEnum.representative.key) {
            AppNavigator.remove(const BottomNavigationForDeliveryUser());
          } else {
            AppNavigator.remove(const NavUserView());
          }
        },
      );
    }
  }

  // String getErrorMessage(ErrorState state, String fieldName) {
  //    try {
  //      final error = state.listOfError.firstWhere(
  //            (error) => error.field == fieldName,
  //        orElse: () => Errors(),
  //      );
  //
  //      dynamic message = error.message;
  //      if (message is List && message.isNotEmpty) {
  //        return message.first.toString();
  //      } else if (message is String) {
  //        return message;
  //      }
  //      return '';
  //    } catch (e) {
  //      return '';
  //    }
  //  }
  Future<void> signUp(int countryId, int cityId, String selectedValue,
      profileImage, String role, LatLng? location) async {
    await AppHelper.closeKeyboard();
    formKey.currentState!.save();
    if (!isAgreedToTerms) {
      AppToast.error('sign_up.agree'.tr());
      return;
    }
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      emit(LoadingAuthState());
      final response = SignUpParam(
        image: profileImage != null
            ? MultipartFile.fromFileSync(profileImage!.path)
            : null,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmController.text,
        name: userNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        role: role,
        countryId: countryId,
        location: location,
        cityId: cityId,
        dialCode: selectedValue,
      );
      final api = await repo.signUp(response);
      api.fold(
        (failure) {
          if (failure.error.isEmpty) {
            String errMsg = "failure.unexpected_error".tr();
            AppToast.error(errMsg);
            emit(AuthInitial());
          } else if (failure.error[0].field == 'general') {
            AppToast.error(failure.error[0].message ?? "");
          }
          for (var error in failure.error) {
            if (error.field == 'dial_code') {
              AppToast.error("phone.code".tr());
            }
          }

          emit(ErrorState(listOfError: failure.error));
        },
        (r) async {
          emit(Success());
          AppToast.success("sign_up.success".tr());
          if (CachHelper.role == UserTypeEnum.shopOwner.key) {
            AppNavigator.remove(const NavShopOwnerView());
          } else if (CachHelper.role == UserTypeEnum.productiveFamilies.key) {
            AppNavigator.remove(const NavProductiveView());
          } else if (CachHelper.role == UserTypeEnum.representative.key) {
            AppNavigator.remove(const BottomNavigationForDeliveryUser());
          } else {
            AppNavigator.remove(const NavUserView());
          }
        },
      );
    } catch (e) {
      ServerFailure.fromCatchError(e);
      log(e.toString());
      emit(AuthInitial());
    }
  }

  Future<void> forgetPassword(String selectedValue) async {
    if (formKey.currentState!.validate()) {
      emit(LoadingAuthState());
      final param = ForgetPasswordParam(
        phone: phoneController.text,
        dialCode: selectedValue,
      );
      final api = await repo.forgetPassword(param);

      api.fold((failure) {
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
          emit(AuthInitial());
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
        emit(ErrorState(listOfError: failure.error));
      }, (r) async {
        emit(Success());
        AppNavigator.push(OtpScreen(
          phone: phoneController.text,
          dialCode: selectedValue,
        ));
      });
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    addressController.dispose();
    userNameController.dispose();
    return super.close();
  }

  Future<void> clear() async {
    isAgreedToTerms = false;
    strengthColor = Colors.red;
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    passwordConfirmController.clear();
    addressController.clear();
    userNameController.clear();
  }
}
