import 'package:dalil_2020_app/models/product_model.dart';
import 'package:dalil_2020_app/models/store_model.dart';

class SellingAndRentProduct {
  int? id;
  ProductName? productName;
  ProductName? productDescription;
  String? price;
  String? priceAfterDiscount;
  List<String>? category;
  List<String>? subCategory;
  String? saleType;
  List<ProductImage>? images;
  int? rating;
  int? totalViews;
  int? orders;
  String? sellerName;
  String? sellerPhone;

  SellingAndRentProduct({
    this.id,
    this.productName,
    this.productDescription,
    this.price,
    this.priceAfterDiscount,
    this.category,
    this.subCategory,
    this.saleType,
    this.images,
    this.totalViews,
    this.orders,
    this.rating,
    this.sellerName,
    this.sellerPhone,
  });

  SellingAndRentProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'] != null
        ? ProductName.fromJson(json['product_name'])
        : null;

    productDescription = json['product_description'] != null
        ? ProductName.fromJson(json['product_description'])
        : null;

    price = json['price']?.toString();
    priceAfterDiscount = json['price_after_discount']?.toString();

    category =
        json['category'] != null ? List<String>.from(json['category']) : null;

    subCategory = json['sub_category'] != null
        ? List<String>.from(json['sub_category'])
        : null;

    saleType = json['sale_type'];

    images = json['image'] != null
        ? List<ProductImage>.from(
            json['image'].map((x) => ProductImage.fromJson(x)))
        : [];

    totalViews = json['total_views'];
    orders = json['orders'];
    rating = json['rating'];
    sellerName = json['seller_name'];
    sellerPhone = json['seller_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;

    if (productName != null) {
      data['product_name'] = productName!.toJson();
    }

    if (productDescription != null) {
      data['product_description'] = productDescription!.toJson();
    }

    data['price'] = price;
    data['price_after_discount'] = priceAfterDiscount;
    data['category'] = category;
    data['sub_category'] = subCategory;
    data['sale_type'] = saleType;

    data['image'] = images?.map((x) => x.toJson()).toList();

    data['total_views'] = totalViews;
    data['orders'] = orders;
    data['rating'] = rating;
    data['seller_name'] = sellerName;
    data['seller_phone'] = sellerPhone;

    return data;
  }
}

class ProductName {
  String? en;
  String? ar;

  ProductName({this.en, this.ar});

  ProductName.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
  }

  Map<String, dynamic> toJson() => {'en': en, 'ar': ar};
}
