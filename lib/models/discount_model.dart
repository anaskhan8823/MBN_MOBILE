class DiscountCardModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String discount;
  final String photo;

  DiscountCardModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.discount,
    required this.photo,
  });

  factory DiscountCardModel.fromJson(Map<String, dynamic> json) {
    return DiscountCardModel(
      id: json['id'],
      nameAr: json['name']?['ar'] ?? "",
      nameEn: json['name']?['en'] ?? "",
      discount: json['discount'] ?? "",
      photo: json['photo'] ?? "",
    );
  }
}
