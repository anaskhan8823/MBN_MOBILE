class ResendCodeParam{
  final String phone;
  final String dialCode;
  ResendCodeParam({required this.phone,required this.dialCode});
  Map<String,dynamic>toJson(){
    return {
      'phone':phone,
      'dial_code':dialCode

    };
  }

}
