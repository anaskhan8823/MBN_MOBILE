import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    this.height,
    required this.item,
    required this.count,
    required this.position,
    required this.updatePosition,
    this.activeDotHeight,
    this.activeDotWidth,
    this.disActiveDotHeight,
    this.disActiveDotWidth,
    this.activeColor,
  });

  final int count;
  final int position;
  final double? height;
  final Function(int i) item;
  final Function(int i) updatePosition;
  final double? activeDotHeight;
  final double? activeDotWidth;
  final double? disActiveDotHeight;
  final double? disActiveDotWidth;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const SizedBox(width: double.infinity),
        CarouselSlider.builder(
          itemCount: count,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            autoPlayCurve: Curves.linearToEaseOut,
            height: height ?? AppSize.getHeight(200),
            onPageChanged: (i, r) => updatePosition(i),
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlayAnimationDuration: const Duration(seconds: 1),
          ),
          itemBuilder: (_, i, any) => item(i),
        ),

        /// INDICATOR
        Column(
          children: [
            DotsIndicator(
              dotsCount: count,
              position: position,
              decorator: DotsDecorator(
                size: Size(AppSize.getWidth(disActiveDotWidth ?? 20),
                    AppSize.getHeight(disActiveDotHeight ?? 3)),
                color: AppColors.separatingSeparator,
                activeColor: activeColor ?? AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
                activeSize: Size(AppSize.getWidth(activeDotWidth ?? 40),
                    AppSize.getHeight(activeDotHeight ?? 3)),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
            ),
            SizedBox(height: AppSize.getHeight(16)),
          ],
        )
      ],
    );
  }
}
