class ProfileShopOwnerSummaryModel {
  String? profileName;
  String? profilePicture;
  int? overallStoreRating;
  int? totalStores;
  int? totalProducts;
  int? totalViews;

  ProfileShopOwnerSummaryModel(
      {this.profileName,
      this.profilePicture,
      this.overallStoreRating,
      this.totalStores,
      this.totalProducts,
      this.totalViews});

  ProfileShopOwnerSummaryModel.fromJson(Map<String, dynamic> json) {
    profileName = json['profile_name'];
    profilePicture = json['profile_picture'];
    overallStoreRating = json['overall_store_rating'];
    totalStores = json['total_stores'];
    totalProducts = json['total_products'];
    totalViews = json['total_views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_name'] = profileName;
    data['profile_picture'] = profilePicture;
    data['overall_store_rating'] = overallStoreRating;
    data['total_stores'] = totalStores;
    data['total_products'] = totalProducts;
    data['total_views'] = totalViews;
    return data;
  }
}
