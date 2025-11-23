import 'package:flutter/material.dart';

import '../../app_assets.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';

class ContainerWithBackgroundImage extends StatelessWidget {
  const ContainerWithBackgroundImage({super.key, required this.child, this.image, this.padding});
  final Widget child;
  final String? image;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.height,
      padding: AppSize.padding(horizontal:padding?? 40),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image??
              (AppColors.isDark()?AppImages.backgroundDark:AppImages.backgroundLight)),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
