class ContactFromListModel {
  int? id;
  String? contactName;
  String? contactImage;
  String? contactRole;
  bool? activeChat;
  String? lastMessage;
  bool? unreadMessages;

  ContactFromListModel(
      {this.id,
      this.contactName,
      this.contactImage,
      this.contactRole,
      this.activeChat,
      this.lastMessage,
      this.unreadMessages});

  ContactFromListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactName = json['contact_name'];
    contactImage = json['contact_image'];
    contactRole = json['contact_role'];
    activeChat = json['active_chat'];
    lastMessage = json['last_message'];
    unreadMessages = json['unread_messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_name'] = this.contactName;
    data['contact_image'] = this.contactImage;
    data['contact_role'] = this.contactRole;
    data['active_chat'] = this.activeChat;
    data['last_message'] = this.lastMessage;
    data['unread_messages'] = this.unreadMessages;
    return data;
  }
}
