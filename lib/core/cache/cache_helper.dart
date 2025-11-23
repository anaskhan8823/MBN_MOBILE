import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static int? userId;
  static String? userName;
  static String? email;
  static String? phoneNumber;
  static int? cityId;
  static String? role;
  static String? address;
  static String? country;
  static String? city;
  static String? token;
  static String? image;
  static String? theme;
  static String? countryCode;
  static String? lang;

  static bool get isAuth => token?.isNotEmpty == true;

  static late final SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('id');
    email = prefs.getString('email');
    address = prefs.getString('address');
    cityId = prefs.getInt('cityId');
    countryCode = prefs.getString('countryCode');
    country = prefs.getString('country');
    role = prefs.getString('role');
    city = prefs.getString('city');
    userName = prefs.getString('name');
    token = prefs.getString('token');
    image = prefs.getString('image');
    phoneNumber = prefs.getString('phone');
    theme = prefs.getString('theme');
    lang = prefs.getString('lang');
  }

  static saveData() {
    if (lang != null) prefs.setString('lang', lang!);
    if (userId != null) prefs.setInt('id', userId!);
    if (cityId != null) prefs.setInt('cityId', cityId!);
    if (countryCode != null) prefs.setString('countryCode', countryCode!);
    if (userName != null) prefs.setString('name', userName!);
    if (email != null) prefs.setString('email', email!);
    if (phoneNumber != null) prefs.setString('phone', phoneNumber!);
    if (role != null) prefs.setString('role', role!);
    if (address != null) prefs.setString('address', address!);
    if (country != null) prefs.setString('country', country!);
    if (city != null) prefs.setString('city', city!);
    if (token != null) prefs.setString('token', token!);
    if (image != null) prefs.setString('image', image!);
    if (theme != null) prefs.setString('theme', theme!);
  }

  static remove() {
    prefs.remove("countryCode");
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('cityId');
    prefs.remove('role');
    prefs.remove('address');
    prefs.remove('country');
    prefs.remove('role');
    prefs.remove('city');
    prefs.remove('token');
    prefs.remove('avatar');
    prefs.remove('theme');
    prefs.remove('lang');
    cityId = null;
    userId = null;
    userName = null;
    email = null;
    phoneNumber = null;
    role = null;
    address = null;
    country = null;
    city = null;
    token = null;
    image = null;
    theme = null;
    lang = null;
  }

  static removeExceptThemeAndLang() {
    prefs.remove("countryCode");
    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('role');
    prefs.remove('address');
    prefs.remove('country');
    prefs.remove('role');
    prefs.remove('city');
    prefs.remove('cityId');
    prefs.remove('token');
    prefs.remove('avatar');
    userId = null;
    cityId = null;
    userName = null;
    email = null;
    phoneNumber = null;
    role = null;
    address = null;
    country = null;
    city = null;
    token = null;
    image = null;
  }
}
