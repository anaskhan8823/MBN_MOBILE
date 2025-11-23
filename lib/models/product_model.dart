import 'dart:io';

class ProductModel {
  int? id;
  ProductName? productName;
  ProductName? description;
  String? price;
  String? priceAfterDiscount;
  List<String>? category;
  List<String>? subCategory;
  String? saleType;
  String? sellerPhone;
  String? sellerName;
  List<ProductImage>? images;
  int? rating;
  int? totalViews;
  int? orders;
  List<File>? imageFiles;

  ProductModel({
    this.id,
    this.productName,
    this.description,
    this.price,
    this.priceAfterDiscount,
    this.category,
    this.subCategory,
    this.saleType,
    this.sellerPhone,
    this.sellerName,
    this.images,
    this.rating,
    this.totalViews,
    this.orders,
    this.imageFiles,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] is int
            ? json['id']
            : int.tryParse(json['id'].toString()),
        productName: json['product_name'] != null
            ? ProductName.fromJson(json['product_name'])
            : null,
        description: json['description'] != null
            ? ProductName.fromJson(json['description'])
            : null,
        price: json['price']?.toString(),
        priceAfterDiscount: json['price_after_discount']?.toString(),
        category: json['category'] != null
            ? List<String>.from(json['category'].map((e) => e.toString()))
            : [],
        subCategory: json['sub_category'] != null
            ? List<String>.from(json['sub_category'].map((e) => e.toString()))
            : [],
        saleType: json['sale_type']?.toString(),
        sellerPhone: json['seller_phone']?.toString(),
        sellerName: json['seller_name']?.toString(),
        images: json['image'] != null
            ? List<ProductImage>.from(
                json['image'].map((x) => ProductImage.fromJson(x)))
            : [],
        rating: json['rating'] is int
            ? json['rating']
            : int.tryParse(json['rating'].toString()),
        totalViews: json['total_views'] is int
            ? json['total_views']
            : int.tryParse(json['total_views'].toString()),
        orders: json['orders'] is int
            ? json['orders']
            : int.tryParse(json['orders']?.toString() ?? '0'),
        imageFiles: [],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (productName != null) data['product_name'] = productName!.toJson();
    if (description != null) data['description'] = description!.toJson();
    data['price'] = price;
    data['price_after_discount'] = priceAfterDiscount;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['sale_type'] = saleType;
    data['seller_phone'] = sellerPhone;
    data['seller_name'] = sellerName;
    data['image'] = images?.map((x) => x.toJson()).toList();
    data['rating'] = rating;
    data['total_views'] = totalViews;
    data['orders'] = orders;
    return data;
  }
}

class ProductName {
  String? en;
  String? ar;

  ProductName({this.en, this.ar});

  factory ProductName.fromJson(Map<String, dynamic> json) => ProductName(
        en: json['en']?.toString(),
        ar: json['ar']?.toString(),
      );

  Map<String, dynamic> toJson() => {'en': en, 'ar': ar};
}

class ProductImage {
  int? id;
  String? url;

  ProductImage({this.id, this.url});

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json['id'],
        url: json['url']?.toString(),
      );

  Map<String, dynamic> toJson() => {'id': id, 'url': url};
}
