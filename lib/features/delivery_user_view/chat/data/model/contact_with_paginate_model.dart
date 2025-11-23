import '../../../home_delivery_user/data/model/chat_model.dart';
import '../../../home_delivery_user/data/model/paginate_model.dart';
import 'contact_model.dart';

class ContactWithPaginateModel {
  List<ContactFromListModel>? items;
  PaginateModel? paginate;

  ContactWithPaginateModel({this.items, this.paginate});

  ContactWithPaginateModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <ContactFromListModel>[];
      json['items'].forEach((v) {
        items!.add(new ContactFromListModel.fromJson(v));
      });
    }
    paginate = json['paginate'] != null
        ? new PaginateModel.fromJson(json['paginate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.paginate != null) {
      data['paginate'] = this.paginate!.toJson();
    }
    return data;
  }
}
