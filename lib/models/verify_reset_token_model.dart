class VerifyModel {
  String? message;
  String? resetToken;

VerifyModel({this.message, this.resetToken});

VerifyModel.fromJson(Map<String, dynamic> json) {
  message = json['message'];
  resetToken = json['reset_token'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = message;
  data['reset_token'] = resetToken;
  return data;
}

}



