import '../../../../models/comments_model.dart';
import '../../../../models/store_model.dart';
import '../../../delivery_user_view/home_delivery_user/data/model/paginate_model.dart';

class PostsModel {
  int? id;
  String? content;
  CategoryPostModel? category;
  User? user;
  String? image;
  int? likesCount;
  int? commentsCount;
  bool? isLiked;
  bool? canEdit;
  String? createdAt;

  PostsModel(
      {this.id,
      this.content,
      this.category,
      this.user,
      this.image,
      this.likesCount,
      this.commentsCount,
      this.isLiked,
      this.canEdit,
      this.createdAt});

  PostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    category = json['category'] != null
        ? new CategoryPostModel.fromJson(json['category'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    image = json['image'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    isLiked = json['is_liked'];
    canEdit = json['can_edit'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['image'] = this.image;
    data['likes_count'] = this.likesCount;
    data['comments_count'] = this.commentsCount;
    data['is_liked'] = this.isLiked;
    data['can_edit'] = this.canEdit;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class CategoryPostModel {
  int? id;
  StoreName? name;

  CategoryPostModel({this.id, this.name});

  CategoryPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new StoreName.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    return data;
  }
}

class PostsWithPagination {
  List<PostsModel>? items;
  PaginateModel? paginate;

  PostsWithPagination({this.items, this.paginate});

  PostsWithPagination.fromJson(Map<String, dynamic> json) {
    // ✅ data -> items
    if (json['data'] != null) {
      items = <PostsModel>[];
      json['data'].forEach((v) {
        items!.add(PostsModel.fromJson(v));
      });
    }

    // ✅ pagination -> paginate
    paginate = json['pagination'] != null
        ? PaginateModel.fromJson(json['pagination'])
        : null;
  }
}
