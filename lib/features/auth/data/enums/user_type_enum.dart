import 'package:easy_localization/easy_localization.dart';

enum UserTypeEnum{
  productiveFamilies,
  shopOwner,
  user,
  representative
}
extension UserTypeEnumExtension on UserTypeEnum {
  String get key {
    switch (this) {
      case UserTypeEnum.productiveFamilies:
        return "productive_families";
      case UserTypeEnum.shopOwner:
        return "shop_owner";
      case UserTypeEnum.user:
        return "user";
      case UserTypeEnum.representative:
        return "representative";
    }
  }

  String get title {
    switch (this) {
      case UserTypeEnum.productiveFamilies:
        return "choose_account.productive_families".tr();
      case UserTypeEnum.shopOwner:
        return "choose_account.shop_owner".tr();
      case UserTypeEnum.representative:
        return "choose_account.representative".tr();
      case UserTypeEnum.user:
        return "choose_account.personal_user".tr();
    }
  }
}