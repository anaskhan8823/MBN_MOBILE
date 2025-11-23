import 'package:dalil_2020_app/models/store_model.dart';

class MapStoresModel {
  int? id;
  StoreName? storeName;
  StoreName? description;
  List<String>? images;
  ContactInfo? contactInfo;
  List<String>? category;
  List<String>? subCategory;
  int? products;
  Location? location;
  String? subscriptionEndDate;
  double? rating;
  List<WorkingTime>? workingTimes;

  MapStoresModel({
    this.id,
    this.storeName,
    this.description,
    this.images,
    this.contactInfo,
    this.category,
    this.subCategory,
    this.products,
    this.location,
    this.subscriptionEndDate,
    this.rating,
    this.workingTimes,
  });

  MapStoresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'] != null
        ? StoreName.fromJson(json['store_name'])
        : null;
    description = json['description'] != null
        ? StoreName.fromJson(json['description'])
        : null;
    images =
        (json['images'] as List?)?.map((e) => e['url'].toString()).toList();
    contactInfo = json['contact_info'] != null
        ? ContactInfo.fromJson(json['contact_info'])
        : null;
    category = (json['category'] as List?)?.map((e) => e.toString()).toList();
    subCategory =
        (json['sub_category'] as List?)?.map((e) => e.toString()).toList();
    products = json['products_count'] ?? (json['products'] as List?)?.length;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    subscriptionEndDate = json['subscription_end_date'];
    rating = double.tryParse(json['rating']?.toString() ?? '');
    workingTimes = (json['working_times'] as List?)
        ?.map((e) => WorkingTime.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'store_name': storeName?.toJson(),
      'description': description?.toJson(),
      'images': images,
      'contact_info': contactInfo?.toJson(),
      'category': category,
      'sub_category': subCategory,
      'products_count': products,
      // 'location': location?.toJson(),
      'subscription_end_date': subscriptionEndDate,
      'rating': rating,
      'working_times': workingTimes?.map((e) => e.toJson()).toList(),
    };
  }
}

class StoreName {
  String? ar;
  String? en;

  StoreName({this.ar, this.en});

  StoreName.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() => {'ar': ar, 'en': en};
}

class ContactInfo {
  String? mobileNumber;
  String? address;

  ContactInfo({this.mobileNumber, this.address});

  ContactInfo.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobile_number'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() =>
      {'mobile_number': mobileNumber, 'address': address};
}

// class Location {
//   Country? country;
//   City? city;
//   String? latitude;
//   String? longitude;

//   Location({this.country, this.city, this.latitude, this.longitude});

//   Location.fromJson(Map<String, dynamic> json) {
//     country =
//         json['country'] != null ? Country.fromJson(json['country']) : null;
//     city = json['city'] != null ? City.fromJson(json['city']) : null;
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() => {
//         'country': country?.toJson(),
//         'city': city?.toJson(),
//         'latitude': latitude,
//         'longitude': longitude,
//       };
// }

class Country {
  int? id;
  String? name;
  String? dialCode;
  String? isoAlpha;

  Country({this.id, this.name, this.dialCode, this.isoAlpha});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dialCode = json['dial_code'];
    isoAlpha = json['ISO_alpha'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dial_code': dialCode,
        'ISO_alpha': isoAlpha,
      };
}

class City {
  int? id;
  String? name;
  int? countryId;

  City({this.id, this.name, this.countryId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = int.tryParse(json['country_id'].toString());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country_id': countryId,
      };
}

// class WorkingTime {
//   int? dayOfWeek;
//   bool? isWorkingDay;
//   String? openingTime;
//   String? closingTime;

//   WorkingTime(
//       {this.dayOfWeek, this.isWorkingDay, this.openingTime, this.closingTime});

//   WorkingTime.fromJson(Map<String, dynamic> json) {
//     dayOfWeek = json['day_of_week'];
//     isWorkingDay = json['is_working_day'];
//     openingTime = json['opening_time'];
//     closingTime = json['closing_time'];
//   }

//   Map<String, dynamic> toJson() => {
//         'day_of_week': dayOfWeek,
//         'is_working_day': isWorkingDay,
//         'opening_time': openingTime,
//         'closing_time': closingTime,
//       };
// }
