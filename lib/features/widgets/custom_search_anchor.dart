import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/style/app_colors.dart';
import '../../core/style/text_style.dart';

class CustomSearchAnchor extends StatelessWidget {
  const CustomSearchAnchor({
    super.key,
    this.color,
    required this.onChanged,
  });

  final Color? color;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(color: color ?? AppColors.primary, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(18)),
      ),
      child: SearchAnchor(
        builder: (context, controller) {
          return SearchBar(
            controller: controller,
            hintText: "navHome.search".tr(),
            hintStyle: WidgetStatePropertyAll(
              kTextStyle16Orange.copyWith(
                  fontSize: 14, color: color ?? AppColors.primary),
            ),
            trailing: [
              if (controller.text.isEmpty)
                Icon(
                  Icons.search,
                  color: color ?? AppColors.primary,
                )
              else
                GestureDetector(
                  onTap: () {
                    controller.clear();
                    onChanged(''); // notify parent that search is cleared
                  },
                  child: Icon(
                    Icons.close,
                    color: color ?? AppColors.primary,
                  ),
                ),
            ],
            onChanged: (val) => onChanged(val),
            onSubmitted: (val) => onChanged(val),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return Future.delayed(Duration.zero);
        },
      ),
    );
  }
}
