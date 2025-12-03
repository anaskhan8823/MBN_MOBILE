import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// class CustomActiveAndNotActiveInCategories2 extends StatefulWidget {
//   const CustomActiveAndNotActiveInCategories2(
//       {super.key,
//       required this.svg,
//       required this.title,
//       required this.borderColor,
//       required this.color,
//       this.screen});
//   final String svg;
//   final String title;
//   final Color borderColor;
//   final Color color;
//   final Widget? screen;

//   @override
//   State<CustomActiveAndNotActiveInCategories2> createState() =>
//       _CustomActiveAndNotActiveInCategoriesState();
// }

// class _CustomActiveAndNotActiveInCategoriesState
//     extends State<CustomActiveAndNotActiveInCategories2> {
//   bool isActive = false;
//   void toggleActive(screen) {
//     setState(() {
//       isActive = !isActive;
//       if (isActive == true) {
//         AppNavigator.push(screen);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isDark = AppColors.isDark();
//     return Column(
//       spacing: AppSize.getHeight(10),
//       children: [
//         GestureDetector(
//           onTap: isDark
//               ? () => toggleActive(widget.screen)
//               : () => AppNavigator.push(widget.screen!),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
//             decoration: BoxDecoration(
//                 color: isActive == false && isDark
//                     ? Colors.transparent
//                     : widget.color,
//                 border: Border.all(
//                     color: isActive == false && isDark
//                         ? Colors.transparent
//                         : widget.borderColor,
//                     width: 4),
//                 borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(16),
//                   topLeft: Radius.circular(16),
//                 )),
//             child: CustomSvg(
//               svg: widget.svg,
//               color: Colors.white,
//               height: AppSize.getHeight(50),
//               width: AppSize.getWidth(50),
//             ),
//           ),
//         ),
//         Text(
//           widget.title.tr(),
//           style: kTextStyle14white.copyWith(color: AppColors.labelInputColor),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }

class CustomActiveAndNotActiveInCategories2 extends StatefulWidget {
  const CustomActiveAndNotActiveInCategories2(
      {super.key,
      required this.svg,
      required this.title,
      required this.subtitle,
      required this.width,
      required this.image,
      required this.borderColor,
      required this.color,
      this.screen});
  final String svg;
  final double width;
  final String image;
  final String title;
  final String subtitle;
  final Color borderColor;
  final Color color;
  final Widget? screen;

  @override
  State<CustomActiveAndNotActiveInCategories2> createState() =>
      _CustomActiveAndNotActiveInCategoriesState();
}

class _CustomActiveAndNotActiveInCategoriesState
    extends State<CustomActiveAndNotActiveInCategories2> {
  bool isActive = false;
  void toggleActive(screen) {
    setState(() {
      isActive = !isActive;
      if (isActive == true) {
        AppNavigator.push(screen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = AppColors.isDark();
    return Column(
      spacing: AppSize.getHeight(10),
      children: [
        GestureDetector(
          onTap:
              // isDark
              // ?
              () => toggleActive(widget.screen),
          // : () => AppNavigator.push(widget.screen!),
          child: Container(
              width: widget.width,
              height: MediaQuery.of(context).size.height * 0.18,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                  color: isActive == false && isDark
                      ? Colors.transparent
                      : widget.color,
                  border: Border.all(
                      color: isActive == false && isDark
                          ? Colors.transparent
                          : widget.borderColor,
                      width: 4),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  )),
              // child: CustomSvg(
              //   svg: widget.svg,
              //   color: Colors.white,
              //   height: AppSize.getHeight(50),
              //   width: AppSize.getWidth(50),
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title.tr(),
                    style: kTextStyle14white.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12),
                  Image.asset(
                    fit: BoxFit.fitHeight,
                    widget.image.toString(),
                    width: 85,
                    height: 85,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
