import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../style/app_colors.dart';
import '../style/app_size.dart';

class AppToast {
  static void error(String msg) {
    Fluttertoast.showToast(
      msg: msg.tr(),
      textColor: Colors.white,
      fontSize: AppSize.font(16),
      backgroundColor: Colors.red,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void success(String msg) {
    Fluttertoast.showToast(
      msg: msg.tr(),
      textColor: Colors.white,
      fontSize: AppSize.font(16),
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: AppColors.iconSuccess,
    );
  }
}
