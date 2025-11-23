class ProfileProductiveFamiliesModel {
  String? profileName;
  String? profilePicture;
  num? overallStoreRating;
  int? totalProducts;
  int? totalViews;
  int? order;

  ProfileProductiveFamiliesModel(
      {this.profileName,
        this.profilePicture,
        this.overallStoreRating,
        this.totalProducts,
        this.totalViews,
        this.order,
       });

  ProfileProductiveFamiliesModel.fromJson(Map<String, dynamic> json) {
    profileName = json['profile_name'];
    profilePicture = json['profile_picture'];
    overallStoreRating = json['overall_store_rating'];
    totalProducts = json['total_products'];
    totalViews = json['total_views'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_name'] = profileName;
    data['profile_picture'] = profilePicture;
    data['overall_store_rating'] = overallStoreRating;
    data['total_products'] = totalProducts;
    data['total_views'] = totalViews;
    data['order'] = order;
    return data;
  }
}
