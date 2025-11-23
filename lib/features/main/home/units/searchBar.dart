import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/app_assets.dart';
import '../../../widgets/custom_search_anchor.dart';

Widget buildSearchBar(void Function()? onTap,
    {required void Function(String) onChanged}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 9.0),
    child: Row(
      spacing: AppSize.getWidth(18),
      children: [
        GestureDetector(
          onTap: onTap,
          child: SizedBox(
              width: AppSize.getWidth(29),
              height: AppSize.getHeight(35),
              child: SvgPicture.asset(
                AppSvg.menu,
              )),
        ),
        Expanded(
          child: CustomSearchAnchor(
            onChanged: (val) => onChanged(val),
          ),
        ),
        Image.asset(
          AppSvg.logoAppBar,
          fit: BoxFit.scaleDown,
          height: AppSize.getHeight(45),
          width: AppSize.getWidth(45),
        ),
      ],
    ),
  );
}
