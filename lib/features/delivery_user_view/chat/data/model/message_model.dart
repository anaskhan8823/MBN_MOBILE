import '../../../../../models/comments_model.dart';

class MessageModel {
  User? user;
  int? id;
  String? type;
  String? content;
  bool? seen;
  String? createdAt;

  MessageModel(
      {this.user, this.id, this.type, this.content, this.seen, this.createdAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    id = json['id'];
    type = json['type'];
    content = json['content'];
    seen = json['seen'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['seen'] = this.seen;
    data['created_at'] = this.createdAt;
    return data;
  }
}
