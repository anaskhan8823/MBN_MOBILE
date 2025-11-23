class Representative_map {
  List<Data>? data;

  Representative_map({this.data});

  Representative_map.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  Location? location;
  List<String>? role;
  String? address;
  String? dialCode;
  String? country;
  int? countryId;
  String? city;
  int? cityId;
  String? avatar;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.location,
      this.role,
      this.address,
      this.dialCode,
      this.country,
      this.countryId,
      this.city,
      this.cityId,
      this.avatar});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    role = json['role'].cast<String>();
    address = json['address'];
    dialCode = json['dial_code'];
    country = json['country'];
    countryId = json['country_id'];
    city = json['city'];
    cityId = json['city_id'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['role'] = this.role;
    data['address'] = this.address;
    data['dial_code'] = this.dialCode;
    data['country'] = this.country;
    data['country_id'] = this.countryId;
    data['city'] = this.city;
    data['city_id'] = this.cityId;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Location {
  Country? country;
  City? city;
  Null? latitude;
  Null? longitude;

  Location({this.country, this.city, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Country {
  int? id;
  String? name;
  String? dialCode;
  String? iSOAlpha;

  Country({this.id, this.name, this.dialCode, this.iSOAlpha});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dialCode = json['dial_code'];
    iSOAlpha = json['ISO_alpha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dial_code'] = this.dialCode;
    data['ISO_alpha'] = this.iSOAlpha;
    return data;
  }
}

class City {
  int? id;
  String? name;
  String? countryId;

  City({this.id, this.name, this.countryId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    return data;
  }
}
