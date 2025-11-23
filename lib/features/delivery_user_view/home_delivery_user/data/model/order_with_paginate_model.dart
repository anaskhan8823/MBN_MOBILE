import 'package:dalil_2020_app/features/delivery_user_view/home_delivery_user/data/model/paginate_model.dart';

import 'order_state_model.dart';

class OrderWithPaginateModel {
  List<OrderStateModel>? items;
  PaginateModel? paginate;

  OrderWithPaginateModel({this.items, this.paginate});

  OrderWithPaginateModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <OrderStateModel>[];
      json['items'].forEach((v) {
        items!.add(new OrderStateModel.fromJson(v));
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
