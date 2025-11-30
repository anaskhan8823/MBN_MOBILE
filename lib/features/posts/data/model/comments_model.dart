import '../../../../models/comments_model.dart';
import '../../../delivery_user_view/home_delivery_user/data/model/paginate_model.dart';

class CommentsModel {
  int? id;
  String? content;
  String? postId;
  User? user;
  bool? canEdit;
  String? createdAt;

  CommentsModel(
      {this.id,
      this.content,
      this.postId,
      this.user,
      this.canEdit,
      this.createdAt});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    postId = json['post_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    canEdit = json['can_edit'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['post_id'] = this.postId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['can_edit'] = this.canEdit;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class CommentsWithPagination {
  List<CommentsModel>? items;
  PaginateModel? paginate;

  CommentsWithPagination({this.items, this.paginate});

  CommentsWithPagination.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <CommentsModel>[];
      json['items'].forEach((v) {
        items!.add(new CommentsModel.fromJson(v));
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
