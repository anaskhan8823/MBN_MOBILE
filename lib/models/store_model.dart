import 'dart:io';

import 'package:dalil_2020_app/models/product_model.dart';

class StoreModel {
  int? id;
  StoreName? storeName;
  StoreName? description;
  List<Images>? images;
  ContactInfo? contactInfo;
  List<String>? category;
  List<String>? subCategory;
  List<Product>? products;
  int? productsCount;
  Location? location;
  String? subscriptionEndDate;
  String? rating;
  List<WorkingTime>? workingTimes;

  StoreModel({
    this.id,
    this.storeName,
    this.description,
    this.images,
    this.contactInfo,
    this.category,
    this.subCategory,
    this.products,
    this.productsCount,
    this.location,
    this.subscriptionEndDate,
    this.rating,
    this.workingTimes,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        id: json['id'],
        storeName: json['store_name'] != null
            ? StoreName.fromJson(json['store_name'])
            : null,
        description: json['description'] != null
            ? StoreName.fromJson(json['description'])
            : null,
        images: json['images'] != null
            ? List<Images>.from(json['images'].map((x) => Images.fromJson(x)))
            : [],
        contactInfo: json['contact_info'] != null
            ? ContactInfo.fromJson(json['contact_info'])
            : null,
        category:
            json['category'] != null ? List<String>.from(json['category']) : [],
        subCategory: json['sub_category'] != null
            ? List<String>.from(json['sub_category'])
            : [],
        products: json['products'] != null
            ? List<Product>.from(
                json['products'].map((x) => Product.fromJson(x)))
            : [],
        productsCount: json['products_count'],
        location: json['location'] != null
            ? Location.fromJson(json['location'])
            : null,
        subscriptionEndDate: json['subscription_end_date']?.toString(),
        rating: json['rating'].toString(),
        workingTimes: json['working_times'] != null
            ? List<WorkingTime>.from(
                json['working_times'].map((x) => WorkingTime.fromJson(x)))
            : [],
      );
}

class StoreName {
  String? en;
  String? ar;

  StoreName({this.en, this.ar});

  factory StoreName.fromJson(Map<String, dynamic> json) => StoreName(
        en: json['en']?.toString(),
        ar: json['ar']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'en': en,
        'ar': ar,
      };
}

class Images {
  int? id;
  String? url;

  Images({this.id, this.url});

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json['id'],
        url: json['url']?.toString(),
      );
}

class ContactInfo {
  String? mobileNumber;
  String? address;

  ContactInfo({this.mobileNumber, this.address});

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        mobileNumber: json['mobile_number']?.toString(),
        address: json['address']?.toString(),
      );
}

class Product {
  int? id;
  StoreName? productName;
  StoreName? description;
  String? price;
  String? priceAfterDiscount;
  List<String>? category;
  List<String>? subCategory;
  String? saleType;
  num? rating;
  List<ProductImage>? image; // renamed to match API better
  List<File>? imageFiles; // local files if needed
  String? sellerName;
  String? sellerPhone;
  int? totalViews;

  Product({
    this.id,
    this.productName,
    this.description,
    this.price,
    this.priceAfterDiscount,
    this.category,
    this.subCategory,
    this.saleType,
    this.rating,
    this.image,
    this.imageFiles,
    this.sellerName,
    this.sellerPhone,
    this.totalViews,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        productName: json['product_name'] != null
            ? StoreName.fromJson(json['product_name'])
            : null,
        description: json['description'] != null
            ? StoreName.fromJson(json['description'])
            : null,
        price: json['price']?.toString(),
        priceAfterDiscount: json['price_after_discount']?.toString(),
        category:
            json['category'] != null ? List<String>.from(json['category']) : [],
        subCategory: json['sub_category'] != null
            ? List<String>.from(json['sub_category'])
            : [],
        saleType: json['sale_type']?.toString(),
        rating: json['rating'],
        image: json['image'] != null
            ? List<ProductImage>.from(
                json['image'].map((x) => ProductImage.fromJson(x)))
            : [],
        imageFiles: [],
        sellerName: json['seller_name']?.toString(),
        sellerPhone: json['seller_phone']?.toString(),
        totalViews: json['total_views'],
      );
}

// class ProductImage {
//   int? id;
//   String? url;

//   ProductImage({this.id, this.url});

//   factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
//         id: json['id'],
//         url: json['url']?.toString(),
//       );
// }

class Location {
  Country? country;
  City? city;
  String? latitude;
  String? longitude;

  Location({this.country, this.city, this.latitude, this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        country:
            json['country'] != null ? Country.fromJson(json['country']) : null,
        city: json['city'] != null ? City.fromJson(json['city']) : null,
        latitude: json['latitude']?.toString(),
        longitude: json['longitude']?.toString(),
      );
}

class Country {
  int? id;
  String? name;
  String? dialCode;
  String? ISOAlpha;

  Country({this.id, this.name, this.dialCode, this.ISOAlpha});

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'],
        name: json['name']?.toString(),
        dialCode: json['dial_code']?.toString(),
        ISOAlpha: json['ISO_alpha']?.toString(),
      );
}

class City {
  int? id;
  String? name;
  String? countryId;

  City({this.id, this.name, this.countryId});

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        name: json['name']?.toString(),
        countryId: json['country_id']?.toString(),
      );
}

class WorkingTime {
  int? dayOfWeek;
  bool? isWorkingDay;
  String? openingTime;
  String? closingTime;

  WorkingTime(
      {this.dayOfWeek, this.isWorkingDay, this.openingTime, this.closingTime});

  factory WorkingTime.fromJson(Map<String, dynamic> json) => WorkingTime(
        dayOfWeek: json['day_of_week'],
        isWorkingDay: json['is_working_day'],
        openingTime: json['opening_time']?.toString(),
        closingTime: json['closing_time']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'day_of_week': dayOfWeek,
        'is_working_day': isWorkingDay,
        'opening_time': openingTime,
        'closing_time': closingTime,
      };
  @override
  String toString() =>
      '${isWorkingDay == true ? "Work" : "Holiday"}: $openingTime - $closingTime';

  // @override
  // String toString() =>
  //     '${isWorkingDay == true ? "Work" : "Holiday"}: $openingTime - $closingTime';
}
