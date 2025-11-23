import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/features/auth/data/params/forget_password_params.dart';
import 'package:dalil_2020_app/features/auth/data/params/resend__code_params.dart';
import 'package:dalil_2020_app/features/auth/data/params/reset_password_params.dart';
import 'package:dalil_2020_app/features/auth/data/params/verif_code_param.dart';
import 'package:dalil_2020_app/models/error_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/dio_helper.dart';
import '../../../../core/end_points.dart';
import '../../../../core/helper/app_toast.dart';
import '../../../../core/utils.dart';
import '../../../../models/user_model.dart';
import '../../../../models/verify_reset_token_model.dart';
import '../params/change_password_params.dart';
import '../params/sign_up_param.dart';
import 'auth_repo.dart';
class AthRepoImpel implements AuthRepo {
  @override
  Future<Either<Failure, bool>> signIn(param) async {
    try {
      final response = await DioHelper.send(
        SIGN_IN,
        data: param.toJson(),
      );
      if (response.isSuccess) {
        Utils.cacheUser(response);
        CachHelper.saveData();
        return right(true);
      }
      else {
        final errorModel = ErrorModel.fromJson(response.data);
        return left(ServerFailure(
            'Error occurred',
            error: errorModel.errors ?? []
        ));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp(SignUpParam param) async {
    try {
      final response = await DioHelper.send(
        SIGN_UP,
        data: param.toJson(),
      );
      if (response.isSuccess) {
        Utils.cacheUser(response);
        CachHelper.saveData();
        return right(UserModel.fromJson(response.data["data"]));
      }
      else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }


  @override
  Future<Either<Failure, bool>> forgetPassword(
      ForgetPasswordParam param) async {
    try {
      final response = await DioHelper.send(FORGET_PASSWORD,
          data: param.toJson()
      );
      if (response.isSuccess) {
        return (right(true));
      }
      else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> resendCode(ResendCodeParam param) async {
    try {
      final response = await DioHelper.send(RESEND_CODE,
          data: param.toJson()
      );
      if (response.isSuccess) {
        return (right(true));
      }
      else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, VerifyModel>> verifyCode(VerifyCodeParam param) async {
    try {
      final response = await DioHelper.send(
          VERIFICATION,
          data: param.toJson()
      );
      if (response.isSuccess) {
        return (right(VerifyModel.fromJson(response.data['data'])));
      }
      else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(ResetPasswordParam param) async {
    try {
      final response = await DioHelper.send(
          RESET_PASSWORD,
          data: param.toJson()
      );
      if (response.isSuccess) {
        return (right(true));
      }
      else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      ChangePasswordParams param) async {
    try {
      final response = await DioHelper.send(
          CHANGE_PASSWORD,
          data: param.toJson()
      );
      if (response.isSuccess) {
        return (right(true));
      }
      else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }
}
