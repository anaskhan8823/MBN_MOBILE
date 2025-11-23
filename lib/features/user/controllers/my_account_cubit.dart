import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/helper/app_toast.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/login/view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/dio_helper.dart';
import '../../../core/end_points.dart';
import '../../../core/errors/failure.dart';
import '../../../core/utils.dart';
part 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  MyAccountCubit() : super(MyAccountInitial());
  final passwordController = TextEditingController();
  bool switchValue = true;
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  void updateObscurePassword() {
    obscurePassword = !obscurePassword;
    emit(UpdateObscurePassword());
  }

  void isSwitchSwitched() {
    switchValue = !switchValue;
    emit(UpdateSwitch());
  }

  Future<void> editProfile(
      int? countryId, int? cityId, profileImage, String? selectedvalue) async {
    try {
      emit(MyAccountLoading());
      final response = await DioHelper.send(EDIT_PROFILE, data: {
        if (profileImage != null)
          "avatar": MultipartFile.fromFileSync(profileImage.path),
        if (userNameController.text.trim().isNotEmpty)
          "name": userNameController.text.trim(),
        if (emailController.text.trim().isNotEmpty)
          "email": emailController.text.trim(),
        if (phoneController.text.trim().isNotEmpty)
          "phone": phoneController.text.trim(),
        if (addressController.text.trim().isNotEmpty)
          "address": addressController.text.trim(),
        if (countryId != null) "country_id": countryId,
        if (cityId != null) "city_id": cityId,
        if (selectedvalue != null) "dial_code": selectedvalue,
      });
      if (response.isSuccess) {
        Utils.cacheUser(response);
        CachHelper.saveData();
        AppToast.success("myProfile.editedSuccessfully");
        AppNavigator.push(Utils.getUser);
        emit(MyAccountSuccess());
      } else {
        ServerFailure responseData = ServerFailure.fromResponse(response);
        AppToast.error(responseData.errMessage);
        emit(MyAccountFailure(response.msg));
      }
    } catch (e) {
      ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      emit(MyAccountInitial());
    }
  }

  Future<void> deleteAccount() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      if (formKey.currentState!.validate()) {
        emit(MyAccountLoading());
        final response = await DioHelper.delete(
            "profile/delete-profile?password=${passwordController.text}",
            data: {"password": passwordController.text});
        if (response.isSuccess) {
          AppToast.success("myProfile.deleted");
          CachHelper.removeExceptThemeAndLang();
          emit(MyAccountSuccess());
          AppNavigator.replace(const SignInScreen());
        } else {
          ServerFailure.fromResponse(response);
          AppToast.error(response.msg);
          emit(MyAccountInitial());
        }
      }
    } catch (e) {
      ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      emit(MyAccountInitial());
    }
  }

  Future<void> contactUs() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      if (formKey.currentState!.validate()) {
        emit(MyAccountLoading());
        final response = await DioHelper.send("user/contact-us", data: {
          "subject": subjectController.text,
          "message": messageController.text
        });
        if (response.isSuccess) {
          AppToast.success("successSend");
          emit(MyAccountSuccess());
          AppNavigator.push(Utils.getUser);
        } else {
          ServerFailure.fromResponse(response);
          AppToast.error(response.msg);
          emit(MyAccountInitial());
        }
      }
    } catch (e) {
      ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      emit(MyAccountInitial());
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    return super.close();
  }
}
