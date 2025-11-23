// class UserModel {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   List<String>? role;
//   String? address;
//   String? country;
//   String? city;
//   String? latitude;
//   String? longitude;
//   String? avatar;
//   String? token;
//   int? country_id;
//   int? city_id;

//   UserModel(
//       {this.id,
//       this.name,
//       this.email,
//       this.phone,
//       this.role,
//       this.address,
//       this.country,
//       this.latitude,
//       this.longitude,
//       this.city,
//       this.avatar,
//       this.city_id,
//       this.country_id,
//       this.token});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     role = json['role'].cast<String>();
//     address = json['address'];
//     country = json['country'];
//     city = json['city'];
//     longitude = json['longitude'];
//     latitude = json['latitude'];
//     avatar = json['avatar'];
//     token = json['token'];
//     country_id = json['country_id'];
//     city_id = json['city_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['phone'] = phone;
//     data['role'] = role;
//     data['address'] = address;
//     data['country'] = country;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['city'] = city;
//     data['avatar'] = avatar;
//     data['token'] = token;
//     data['country_id'] = country_id;
//     data['city_id'] = city_id;

//     return data;
//   }
// }

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  List<String>? role;
  String? address;
  String? country;
  String? city;
  String? latitude;
  String? longitude;
  String? avatar;
  String? token;
  int? country_id;
  int? city_id;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.address,
    this.country,
    this.latitude,
    this.longitude,
    this.city,
    this.avatar,
    this.city_id,
    this.country_id,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role']?.cast<String>();

    address = json['address'];
    avatar = json['avatar'];
    token = json['token'];

    // OLD compatibility (agar direct ho to)
    country_id = json['country_id'];
    city_id = json['city_id'];
    country = json['country'];
    city = json['city'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    // NEW nested location handling
    if (json['location'] != null) {
      final loc = json['location'];
      latitude = loc['latitude']?.toString();
      longitude = loc['longitude']?.toString();

      if (loc['country'] != null) {
        country_id = loc['country']['id'];
        country = loc['country']['name'];
      }

      if (loc['city'] != null) {
        city_id = loc['city']['id'];
        city = loc['city']['name'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['address'] = address;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['city'] = city;
    data['avatar'] = avatar;
    data['token'] = token;
    data['country_id'] = country_id;
    data['city_id'] = city_id;
    return data;
  }
}
