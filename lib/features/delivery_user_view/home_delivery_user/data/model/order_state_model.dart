// import 'chat_model.dart';

// class OrderStateModel {
//   int? id;
//   String? username;
//   String? status;
//   String? userPhone;
//   String? address;
//   String? avatar;
//   ChatModel? chat;
//   String? chatString;

//   OrderStateModel(
//       {this.id,
//       this.username,
//       this.status,
//       this.chat,
//       this.chatString,
//       this.userPhone,
//       this.address,
//       this.avatar});

//   OrderStateModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     status = json['status'];
//     userPhone = json['user_phone'];
//     address = json['address'];
//     avatar = json['avatar'];
//     try {
//       chat = json['chat'] != null ? new ChatModel.fromJson(json['chat']) : null;
//     } catch (e) {
//       chatString = json['chat'];
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['status'] = this.status;
//     data['user_phone'] = this.userPhone;
//     data['address'] = this.address;
//     data['avatar'] = this.avatar;
//     if (this.chat != null) {
//       data['chat'] = this.chat!.toJson();
//     }
//     return data;
//   }
// }

import 'chat_model.dart';

class OrderStateModel {
  int? id;
  String? username;
  String? status;
  String? userPhone;
  String? address;
  String? avatar;
  ChatModel? chat;
  String? chatString;

  OrderStateModel({
    this.id,
    this.username,
    this.status,
    this.chat,
    this.chatString,
    this.userPhone,
    this.address,
    this.avatar,
  });

  OrderStateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    status = json['status'];
    userPhone = json['user_phone'];
    address = json['address'];
    avatar = json['avatar'];
    try {
      chat = json['chat'] != null ? ChatModel.fromJson(json['chat']) : null;
    } catch (e) {
      chatString = json['chat'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['status'] = status;
    data['user_phone'] = userPhone;
    data['address'] = address;
    data['avatar'] = avatar;
    if (chat != null) {
      data['chat'] = chat!.toJson();
    }
    return data;
  }

  // ✅ Add this copyWith method
  OrderStateModel copyWith({
    int? id,
    String? username,
    String? status,
    String? userPhone,
    String? address,
    String? avatar,
    ChatModel? chat,
    String? chatString,
  }) {
    return OrderStateModel(
      id: id ?? this.id,
      username: username ?? this.username,
      status: status ?? this.status,
      userPhone: userPhone ?? this.userPhone,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
      chat: chat ?? this.chat,
      chatString: chatString ?? this.chatString,
    );
  }
}
