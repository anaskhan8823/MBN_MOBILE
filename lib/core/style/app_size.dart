// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppSize {
  /// REFERENCE VALUES FROM THE FIGMA DESIGN.
  static const num _designWidth = 428;
  static const num _designHeight = 926;
  static const num _designStatusBar = 44;

  /// INITIALIZE SIZE USING THE PHYSICAL SIZE AND DEVICE PIXEL RATIO.
  static final Size _size = WidgetsBinding.instance.window.physicalSize /
      WidgetsBinding.instance.window.devicePixelRatio;

  /// GET THE DEVICE VIEWPORT WIDTH.
  static double get _width => _size.width;

  /// GET THE DEVICE VIEWPORT HEIGHT AND WIDTH.
  static double get width => _size.width;
  static double get height => _size.height;

  /// GET THE DEVICE VIEWPORT HEIGHT, ACCOUNTING FOR STATUS BAR AND BOTTOM BAR.
  static double get _height {
    num statusBar = MediaQueryData.fromView(
      WidgetsBinding.instance.window,
    ).viewPadding.top;
    num bottomBar = MediaQueryData.fromView(
      WidgetsBinding.instance.window,
    ).viewPadding.bottom;
    return (_size.height - statusBar - bottomBar).toDouble();
  }

  /// CALCULATE HORIZONTAL SIZE ACCORDING TO VIEWPORT WIDTH.
  static double getWidth(double px) {
    return (px * _width) / _designWidth;
  }

  /// CALCULATE VERTICAL SIZE ACCORDING TO VIEWPORT HEIGHT.
  static double getHeight(double px) {
    return (px * _height) / (_designHeight - _designStatusBar);
  }

  /// GET THE SMALLEST SIZE FOR IMAGE HEIGHT AND WIDTH.
  static double getSize(double px) {
    double vSize = getHeight(px);
    double hSize = getWidth(px);
    return (vSize < hSize)
        ? vSize.toInt().toDouble()
        : hSize.toInt().toDouble();
  }

  /// GET FONT SIZE ACCORDING TO VIEWPORT.
  static double font(double px) => getSize(px);

  /// SET PADDING RESPONSIVELY.
  static EdgeInsetsGeometry padding({
    double? all,
    double? top,
    double? end,
    double? start,
    double? bottom,
    double? vertical,
    double? horizontal,
  }) {
    return _getMarginOrPadding(
      all: all,
      top: top,
      end: end,
      start: start,
      bottom: bottom,
      vertical: vertical,
      horizontal: horizontal,
    );
  }

  /// SET MARGIN RESPONSIVELY.
  static EdgeInsetsDirectional margin({
    double? all,
    double? top,
    double? end,
    double? start,
    double? bottom,
    double? vertical,
    double? horizontal,
  }) {
    return _getMarginOrPadding(
      all: all,
      top: top,
      end: end,
      start: start,
      bottom: bottom,
      vertical: vertical,
      horizontal: horizontal,
    );
  }

  /// GET PADDING OR MARGIN RESPONSIVELY.
  static EdgeInsetsDirectional _getMarginOrPadding({
    double? all,
    double? top,
    double? end,
    double? start,
    double? bottom,
    double? vertical,
    double? horizontal,
  }) {
    if (all != null) {
      top = all;
      end = all;
      start = all;
      bottom = all;
    }
    if (horizontal != null) {
      start = horizontal;
      end = horizontal;
    }
    if (vertical != null) {
      top = vertical;
      bottom = vertical;
    }
    return EdgeInsetsDirectional.only(
      top: getHeight(top ?? 0),
      end: getWidth(end ?? 0),
      bottom: getHeight(bottom ?? 0),
      start: getWidth(start ?? 0),
    );
  }
}
