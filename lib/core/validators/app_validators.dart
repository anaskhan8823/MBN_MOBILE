import 'package:easy_localization/easy_localization.dart';

class AppValidators {
  /// REQUIRED VALIDATION
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else {
      return null;
    }
  }

  static String? passwordStrong(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (value.length <= 8) {
      return 'validators.password.min_length'.tr();
    } else if (RegExp(r'[A-Z]').hasMatch(value) == false) {
      return 'validators.password.contain_upper_case'.tr();
    } else if (RegExp(r'[a-z]').hasMatch(value) == false) {
      return 'validators.password.contain_small_case'.tr();
    } else if (RegExp(r'[0-9]').hasMatch(value) == false) {
      return 'validators.password.contain_number'.tr();
    } else if (RegExp(r'[@#$!|<>=+-]').hasMatch(value) == false) {
      return 'validators.password.contain_special_char'.tr();
    } else {
      return null;
    }
  }

  /// REQUIRED LENGTH VALIDATION
  static String? minLength(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (value.length < length) {
      return 'validators.length.min'.tr(namedArgs: {'length': '$length'});
    } else {
      return null;
    }
  }

  /// MAXIMUM LENGTH VALIDATION
  static String? maxLength(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (value.length > length) {
      return 'validators.length.max'.tr(namedArgs: {'length': '$length'});
    } else {
      return null;
    }
  }

  /// REQUIRED EXACT LENGTH VALIDATION
  static String? exactLength(String? value, int length) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (value.length != length) {
      return 'validators.length.exact'.tr(namedArgs: {'length': '$length'});
    } else {
      return null;
    }
  }

  /// EMAIL VALIDATION
  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return 'validators.email.required'.tr();
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'validators.email.pattern'.tr();
    } else {
      return null;
    }
  }

  /// PASSWORD VALIDATION
  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return 'validators.password.required'.tr();
    }
    return null;
  }

  /// OLD PASSWORD NOT THE SAME AS NEW PASSWORD
  static String? oldPasswordNotNew(String? oldPassword, String? newPassword) {
    if (oldPassword == null || oldPassword.isEmpty) {
      return 'validators.password.required'.tr();
    } else if (newPassword == null || newPassword.isEmpty) {
      return 'validators.password.required'.tr();
    } else if (oldPassword == newPassword) {
      return 'validators.password.old_new_same'.tr();
    } else {
      return null;
    }
  }

  /// PASSWORD IDENTICAL
  static String? passwordIdentical(String? value, String? other) {
    if (value == null || value.isEmpty) {
      return 'validators.password.required'.tr();
    } else if (value != other) {
      return 'validators.password.identical'.tr();
    } else {
      return null;
    }
  }

  /// PHONE NUMBER VALIDATION
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.phone.required'.tr();
    } else {}
  }

  /// ONLY NUMBERS AND LENGTH
  static String? onlyNumbers(String? value, {int? length}) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    } else if (length != null && value.length != length) {
      return 'validators.numbers.exact_length'.tr(
        namedArgs: {'length': '$length'},
      );
    } else {
      return null;
    }
  }

  /// NUMBER LESS THAN VALIDATION
  static String? numLessThan(String? value, int max) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    } else {
      int? intValue = int.tryParse(value);
      if (intValue == null) {
        return 'validators.numbers.only'.tr();
      } else if (intValue >= max) {
        return 'validators.numbers.less_than'.tr(namedArgs: {'max': '$max'});
      } else {
        return null;
      }
    }
  }

  /// VALUE IN RANGE VALIDATION
  static String? numInRange(String? value, int min, int max) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    } else {
      int? intValue = int.tryParse(value);
      if (intValue == null) {
        return 'validators.numbers.only'.tr();
      } else if (intValue < min || intValue > max) {
        return 'validators.numbers.range'.tr(
          namedArgs: {'min': '$min', 'max': '$max'},
        );
      } else {
        return null;
      }
    }
  }

  /// NUMBER GREATER THAN VALIDATION
  static String? numGreaterThan(String? value, int min) {
    if (value == null || value.isEmpty) {
      return 'validators.required'.tr();
    } else if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'validators.numbers.only'.tr();
    } else {
      int? intValue = int.tryParse(value);
      if (intValue == null) {
        return 'validators.numbers.only'.tr();
      } else if (intValue <= min) {
        return 'validators.numbers.greater_than'.tr(namedArgs: {'min': '$min'});
      } else {
        return null;
      }
    }
  }

  /// OTP VALIDATION
  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'validators.OTP.required'.tr();
    } else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'validators.OTP.length'.tr();
    } else {
      return null;
    }
  }
}
