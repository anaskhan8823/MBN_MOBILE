import 'package:flutter/material.dart';

class AppShadow {
  static List<BoxShadow> primary = [
    BoxShadow(
      blurRadius: 2,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 1.0),
      color: Color(0xff101828).withValues(alpha: .5),
    ),
  ];
}
