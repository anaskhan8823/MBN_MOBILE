import 'package:google_maps_flutter/google_maps_flutter.dart';

class SignUpParam {
  final String name, email, phone, password, passwordConfirmation, role;
  final int? countryId, cityId;
  final String? address;
  final LatLng? location;
  final dynamic image;
  final String dialCode;
  SignUpParam({
    required this.dialCode,
    required this.password,
    required this.passwordConfirmation,
    required this.email,
    required this.role,
    this.image,
    this.cityId,
    this.location,
    this.countryId,
    this.address,
    required this.phone,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "avatar": image ?? '',
      "name": name,
      "email": email,
      "phone": phone,
      "dial_code": dialCode,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "role": role,
      if (countryId != null) "country_id": countryId,
      if (cityId != null) "city_id": cityId,
      if (address != null) "address": address,
      if (address != null) "address": address,
      if (location != null) "latitude": location?.latitude,
      if (location != null) "longitude": location?.longitude,
    };
  }
}
