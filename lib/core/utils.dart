import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/features/auth/data/enums/user_type_enum.dart';
import 'package:dalil_2020_app/features/intro/splash/presentation/screens/splash_screen.dart';
import 'package:dalil_2020_app/features/main/home/nav_driver_view.dart';
import 'package:dalil_2020_app/features/main/home/nav_productive_families_view.dart';
import 'package:dalil_2020_app/features/main/home/nav_shop_owner_view.dart';
import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../constans.dart';
import '../features/delivery_user_view/bottom_navigation/presentation/view/bottom_navigation_for_delivery_user.dart';
import '../features/main/home/widget/main_bottom_navigation_for_delivery_user.dart';
import '../features/main/home/widget/main_nav_productive_families_view.dart';
import '../features/main/home/widget/main_nav_shop_owner_view.dart';
import '../features/main/home/widget/main_nav_user_view.dart';
import 'dio_helper.dart';
import 'helper/app_navigator.dart';

class Utils {
  static int items(String value, int items) {
    if (value == kViewFromHome) {
      if (items > 5) {
        return items = 4;
      }
    }
    return items;
  }

  static Widget get getUser {
    if (CachHelper.token == null) {
      return const SplashScreen();
    } else if (CachHelper.token != null &&
        CachHelper.role == UserTypeEnum.shopOwner.key) {
      return const NavShopOwnerView();
    } else if (CachHelper.token != null &&
        CachHelper.role == UserTypeEnum.productiveFamilies.key) {
      return const NavProductiveView();
    } else if (CachHelper.token != null &&
        CachHelper.role == UserTypeEnum.representative.key) {
      return const BottomNavigationForDeliveryUser();
    }
    return const NavUserView();
  }

  static Widget get getBottomNavigationBar {
    if (CachHelper.token == null) {
      return const SizedBox();
    } else if (CachHelper.token != null &&
        CachHelper.role == UserTypeEnum.shopOwner.key) {
      return const MainNavShopOwnerView();
    } else if (CachHelper.token != null &&
        CachHelper.role == UserTypeEnum.productiveFamilies.key) {
      return const MainNavProductiveView();
    } else if (CachHelper.token != null &&
        CachHelper.role == UserTypeEnum.representative.key) {
      return MaionBottomNavigationForDeliveryUser();
    }
    return const MainNavUserView();
  }

  static cacheUser(CustomResponse response) {
    final data = response.data['data'];
    CachHelper.userId = data['id'];
    CachHelper.countryCode = data['dial_code'];
    CachHelper.userName = data['name'];
    CachHelper.email = data['email'];
    CachHelper.phoneNumber = data['phone'];
    CachHelper.cityId = data['city_id'];
    CachHelper.address = data['address'];
    CachHelper.country = data['country'];
    CachHelper.city = data['city'];
    CachHelper.image = data['avatar'];
    CachHelper.token = data['token'];
    CachHelper.role = data['role'][0];
  }

  static String get titleOfDrawerToNavigateToOwnHome {
    final role = CachHelper.role;
    if (role == UserTypeEnum.shopOwner.key) {
      return tr("homeShopOwner.shopDetails");
    }
    if ((role == UserTypeEnum.productiveFamilies.key)) {
      return tr('homeProductive.myProducts');
    }
    if (role == UserTypeEnum.representative.key) {
      return tr('homeProductive.myorder');
    } //ADD DRIVER TEXT
    return '';
  }

  static Function() get navigateToOwnHome {
    final role = CachHelper.role;
    if (role == UserTypeEnum.shopOwner.key) {
      return () => AppNavigator.push(const NavShopOwnerView());
    }
    if (role == UserTypeEnum.productiveFamilies.key) {
      return () => AppNavigator.push(const NavProductiveView());
    }
    if (role == UserTypeEnum.representative.key) {
      return () => AppNavigator.push(const BottomNavigationForDeliveryUser());
    }

    return () {
      //ADD THE DRIVER NAVIGATION
    };
  }
}
