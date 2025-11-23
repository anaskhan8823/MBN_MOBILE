part of '../main/home/components/home_user/view/home_user.dart';

class CustomActiveAndNotActiveInCategories extends StatefulWidget {
  const CustomActiveAndNotActiveInCategories(
      {super.key,
      required this.svg,
      required this.title,
      required this.borderColor,
      required this.color,
      this.screen});
  final String svg;
  final String title;
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
            child: CustomSvg(
              svg: widget.svg,
              color: Colors.white,
              height: AppSize.getHeight(50),
              width: AppSize.getWidth(50),
            ),
          ),
        ),
        Text(
          widget.title.tr(),
          style: kTextStyle14white.copyWith(color: AppColors.labelInputColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
