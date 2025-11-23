import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/text_style.dart';
import '../control/map_stores_cubit.dart';

class CustomSearchAnchorSearch extends StatelessWidget {
  const CustomSearchAnchorSearch({
    super.key,
    this.color,
  });
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
          border: Border.all(color: color ?? AppColors.primary, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: SearchAnchor(
        builder: (context, controller) => SearchBar(
          hintText: "navHome.search".tr(),
          hintStyle: WidgetStatePropertyAll(
            kTextStyle16Orange.copyWith(
                fontSize: 14, color: color ?? AppColors.primary),
          ),
          trailing: [
            Icon(
              Icons.search,
              color: color ?? AppColors.primary,
            ),
          ],
          onSubmitted: (val) {
            context.read<MapStoresCubit>().getStoresList(text: val);
          },
        ),
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return Future.delayed(Duration.zero);
        },
      ),
    );
  }
}
