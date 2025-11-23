

class SignInParam {
  final String password;
  final String? phoneNumber;
  final String?dialCode;

  SignInParam( {
    this.phoneNumber,
    required this.password,
    required this.dialCode,
  });

  Map<String, dynamic> toJson() {
    /// Get FCM Token
    // final String? fcmToken = CacheHelper.get(CacheKeys.fcmToken);
    return {
      'phone':phoneNumber,
      'password': password,
      'dial_code': dialCode,
      // if (fcmToken != null) "fcmToken": fcmToken,
    };
  }
}
