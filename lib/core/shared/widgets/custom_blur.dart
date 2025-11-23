import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBlur extends StatelessWidget {
  const CustomBlur({
    super.key,
    this.sigma,
    this.radius,
    required this.child,
  });

  final Widget child;
  final double? sigma;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          radius != null ? BorderRadius.circular(radius!) : BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma ?? 10.0, sigmaY: sigma ?? 10.0),
        child: child,
      ),
    );
  }
}
