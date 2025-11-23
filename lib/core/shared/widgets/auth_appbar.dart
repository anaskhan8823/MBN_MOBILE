import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../features/main/home/units/switch_button_with_icon.dart';
import '../../app_assets.dart';
import '../../cache/cache_helper.dart';
import '../../language/cubit/language_cubit.dart';
import '../../language/custom_change_lang.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';

class AuthAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppbar(
      {super.key,
      this.title,
      this.showLang = true,
      this.onTap,
      this.hideBackButton = false,
      this.bottom,
      this.heightAppBar,
      this.color,
      this.actions});
  final bool hideBackButton;
  final String? title;
  final PreferredSize? bottom;
  final bool showLang;
  final void Function()? onTap;
  final double? heightAppBar;
  final Color? color;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      bool isEn = state.locale.languageCode == 'en';
      return AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        titleSpacing: 0,
        // toolbarOpacity: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottom: bottom,
        title: Text(
          context.tr(title ?? ''),
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: (CachHelper.lang ?? 'ar') == 'ar'
                  ? 'STV'
                  : GoogleFonts.poppins().fontFamily ?? 'Poppins',
              color: color ?? AppColors.primary),
        ),
        leadingWidth: 40,
        leading: hideBackButton
            ? const SizedBox()
            : CustomIcon(
                padding: isEn
                    ? const EdgeInsets.only(left: 16)
                    : const EdgeInsets.only(right: 5),
                onTap: onTap ?? () => AppNavigator.pop(),
                icon: isEn ? AppIcons.arrowLeft : AppIcons.arrowRight,
                width: AppSize.getWidth(24),
                height: AppSize.getHeight(24),
                color: color ?? AppColors.iconColor,
              ),
        actions: showLang == true
            ? [
                BuildSwitchMenuItemWithIcons(
                  color: AppColors.iconPrimaryOfTheme,
                ),
                SizedBox(width: AppSize.getWidth(12)),
                const CustomChangeLang(),
                SizedBox(width: AppSize.getWidth(12)),
              ]
            : actions,
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar ?? kToolbarHeight);
}
