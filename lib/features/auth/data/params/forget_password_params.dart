class ForgetPasswordParam{
  final String phone;
  final String dialCode;
  ForgetPasswordParam( {required this.phone,required this.dialCode});
  Map<String,dynamic>toJson(){
    return {
      'phone':phone,
      'dial_code':dialCode

    };
  }

}