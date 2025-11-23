import 'package:dalil_2020_app/features/auth/data/params/forget_password_params.dart';
import 'package:dalil_2020_app/features/auth/data/params/reset_password_params.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../models/user_model.dart';
import '../../../../models/verify_reset_token_model.dart';
import '../params/change_password_params.dart';
import '../params/resend__code_params.dart';
import '../params/sign_up_param.dart';
import '../params/sign_in_param.dart';
import '../params/verif_code_param.dart';

abstract class AuthRepo{
  Future<Either<Failure, bool>> signIn(SignInParam param);
  Future<Either<Failure, UserModel>> signUp(SignUpParam param);
  Future<Either<Failure, bool>> forgetPassword(ForgetPasswordParam param);
  Future<Either<Failure, bool>> resendCode(ResendCodeParam param);
  Future<Either<Failure, VerifyModel>> verifyCode(VerifyCodeParam param);
  Future<Either<Failure, bool>> resetPassword(ResetPasswordParam param);
  Future<Either<Failure, bool>> changePassword(ChangePasswordParams param);
}