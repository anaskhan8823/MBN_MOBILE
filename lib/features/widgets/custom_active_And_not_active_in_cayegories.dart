// part of '../main/home/components/home_user/view/home_user.dart';

// class CustomActiveAndNotActiveInCategories extends StatefulWidget {
//   const CustomActiveAndNotActiveInCategories(
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
//   State<CustomActiveAndNotActiveInCategories> createState() =>
//       _CustomActiveAndNotActiveInCategoriesState();
// }

// class _CustomActiveAndNotActiveInCategoriesState
//     extends State<CustomActiveAndNotActiveInCategories> {
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

part of '../main/home/components/home_user/view/home_user.dart';

class CustomActiveAndNotActiveInCategories extends StatefulWidget {
  const CustomActiveAndNotActiveInCategories(
      {super.key,
      required this.svg,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.borderColor,
      required this.color,
      this.screen});
  final String svg;
  final String image;
  final String title;
  final String subtitle;
  final Color borderColor;
  final Color color;
  final Widget? screen;

  @override
  State<CustomActiveAndNotActiveInCategories> createState() =>
      _CustomActiveAndNotActiveInCategoriesState();
}

class _CustomActiveAndNotActiveInCategoriesState
    extends State<CustomActiveAndNotActiveInCategories> {
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
          onTap: isDark
              ? () => toggleActive(widget.screen)
              : () => AppNavigator.push(widget.screen!),
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title.tr(),
                          style: kTextStyle14white.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 6),
                        Text(
                          widget.subtitle,
                          style: kTextStyle14white.copyWith(
                            fontSize: 12,
                            color: AppColors.labelInputColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Image.asset(
                    fit: BoxFit.fitHeight,
                    widget.image.toString(),
                    width: 95,
                    height: 95,
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

// part of '../main/home/components/home_user/view/home_user.dart';

// class CustomActiveAndNotActiveInCategories extends StatefulWidget {
//   const CustomActiveAndNotActiveInCategories(
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
//   State<CustomActiveAndNotActiveInCategories> createState() =>
//       _CustomActiveAndNotActiveInCategoriesState();
// }

// class _CustomActiveAndNotActiveInCategoriesState
//     extends State<CustomActiveAndNotActiveInCategories> {
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
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
//               decoration: BoxDecoration(
//                   color: isActive == false && isDark
//                       ? Colors.transparent
//                       : widget.color,
//                   border: Border.all(
//                       color: isActive == false && isDark
//                           ? Colors.transparent
//                           : widget.borderColor,
//                       width: 4),
//                   borderRadius: const BorderRadius.only(
//                     bottomRight: Radius.circular(16),
//                     topLeft: Radius.circular(16),
//                   )),
//               // child: CustomSvg(
//               //   svg: widget.svg,
//               //   color: Colors.white,
//               //   height: AppSize.getHeight(50),
//               //   width: AppSize.getWidth(50),
//               // ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Productive Families",
//                     style: kTextStyle14white.copyWith(
//                       color: AppColors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                   SizedBox(height: 6),
//                   Image.asset(
//                     "assets/undraw_fitting-pieces_k7hv.png",
//                     width: 95,
//                     height: 95,
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     textAlign: TextAlign.center,
//                     "The largest gathering to support and empower productive families",
//                     style: kTextStyle14white.copyWith(
//                       fontSize: 12,
//                       color: AppColors.labelInputColor,
//                     ),
//                   ),
//                   SizedBox(width: 12),
//                 ],
//               )),
//         ),
//       ],
//     );
//   }
// }
