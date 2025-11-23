import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/text_style.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../user/controllers/my_account_cubit.dart';

class BuildSwitchMenuItemWithIcons extends StatelessWidget {
  const BuildSwitchMenuItemWithIcons({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    bool isDark = AppColors.isDark();
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      final cubit = context.read<ThemeCubit>();
      return IconButton(
          onPressed: () {
            context.read<ThemeCubit>().changeThemeMode();
            context.read<ThemeCubit>().restartApplication();
            print('cubit:${cubit.state.mode}');
          },
          icon: Icon(
            cubit.state.mode == ThemeMode.light ? Icons.sunny : Icons.dark_mode,
            color: color,
          ));
    });
  }
}
