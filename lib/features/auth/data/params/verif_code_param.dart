class VerifyCodeParam{
  final String phone;
  final String otp;
  final String dialCode;
  VerifyCodeParam( {required this.phone,required this.otp,required this.dialCode});
  Map<String,dynamic>toJson(){
    return {
      'phone':phone,
      'otp':otp,
      'dial_code':dialCode
    };
  }

}