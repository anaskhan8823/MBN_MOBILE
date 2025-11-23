class ChangePasswordParams {
  final String currentPass;
  final String newPass;
  final String confirmPass;
  ChangePasswordParams(
      {required this.currentPass,
      required this.newPass,
      required this.confirmPass});
  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPass,
      'new_password': newPass,
      'new_password_confirmation': confirmPass
    };
  }
}
