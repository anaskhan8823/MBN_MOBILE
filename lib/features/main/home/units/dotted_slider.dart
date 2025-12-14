import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../../../core/style/app_colors.dart';

class DottedSlider extends StatelessWidget {
  DottedSlider({
    super.key,
    required this.sliderImages,
    required this.currentIndex,
    this.color,
  });
  final List<String> sliderImages;
  int currentIndex;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DotsIndicator(
        dotsCount: sliderImages.length,
        position: currentIndex,
        decorator: DotsDecorator(
          activeColor: color ?? AppColors.primary,
          color: AppColors.isDark() ? Colors.white : Colors.grey.shade300,
          activeSize: const Size(40.0, 5.0),
          size: const Size(25, 5),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          spacing: const EdgeInsets.symmetric(horizontal: 4.0),
        ),
      ),
    );
  }
}
