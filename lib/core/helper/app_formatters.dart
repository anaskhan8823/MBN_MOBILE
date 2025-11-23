import 'package:flutter/services.dart';

class AppFormatters {
  /// Generic formatter that validates input based on the provided regex
  static TextInputFormatter format(String regExp) {
    return TextInputFormatter.withFunction((oldV, newV) {
      final regex = RegExp('^$regExp*\$');
      if (newV.text.isEmpty || regex.hasMatch(newV.text)) return newV;
      return oldV;
    });
  }

  /// Formatter to allow only Arabic letters and spaces
  static TextInputFormatter get arabic {
    return format(r'[\u0600-\u06FF\s]');
  }

  /// Formatter to allow only English letters and spaces
  static TextInputFormatter get english {
    return format(r'[a-zA-Z\s]');
  }

  /// Formatter to allow both Arabic and English letters and spaces
  static TextInputFormatter get arabicEnglish {
    return format(r'[\u0600-\u06FFa-zA-Z\s]');
  }

  /// Formatter to allow only numeric input
  static TextInputFormatter get numbers {
    return format(r'[0-9]');
  }

  /// Formatter to allow phone numbers (with optional + sign at the start)
  static TextInputFormatter get phone {
    return format(r'[+0-9]');
  }

  /// Formatter to allow names (Arabic, English, and spaces)
  static TextInputFormatter get names {
    return format(r'[\u0600-\u06FFa-zA-Z\s]');
  }

  /// Formatter to allow email-like input
  static TextInputFormatter get email {
    return format(r'[a-zA-Z0-9@._-]');
  }

  /// Formatter to allow specific custom format (example for dates: `dd-mm-yyyy`)
  static TextInputFormatter get date {
    return format(r'[0-9/-]');
  }

  /// Formatter to allow no special characters (letters, numbers, and spaces only)
  static TextInputFormatter get noSpecialCharacters {
    return format(r'[a-zA-Z0-9\u0600-\u06FF\s]');
  }
}
