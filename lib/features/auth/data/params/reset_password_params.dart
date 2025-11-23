class ResetPasswordParam{
  final String phoneNumber;
  final String password;
  final String passwordConfirmation;
  final String resetToken;
  final String dialCode;
  ResetPasswordParam(
      {required this.password,required this.passwordConfirmation,required this.resetToken,required this.phoneNumber,required this.dialCode});
  Map<String,dynamic>toJson(){
    return {
      "phone":phoneNumber,
      "password":password,
      "password_confirmation":passwordConfirmation,
      "reset_token":resetToken,
      'dial_code':dialCode

    };
  }

}
