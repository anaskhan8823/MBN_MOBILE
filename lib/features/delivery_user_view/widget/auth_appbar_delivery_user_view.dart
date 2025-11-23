import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/language/cubit/language_cubit.dart';
import '../../../../core/language/custom_change_lang.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';

class AuthAppbarDeliveryUserView extends StatelessWidget
    implements PreferredSizeWidget {
  const AuthAppbarDeliveryUserView(
      {super.key,
      this.title,
      this.showLang = true,
      this.onTap,
      this.hideBackButton = false,
      this.bottom,
      this.actionWidget,
      this.colorOfTitle,
      this.heightAppBar,
      this.colorOfBackButton});
  final bool hideBackButton;
  final String? title;
  final PreferredSize? bottom;
  final bool showLang;
  final void Function()? onTap;
  final double? heightAppBar;
  final Color? colorOfBackButton;
  final Color? colorOfTitle;
  final Widget? actionWidget;
  @override
  Widget build(BuildContext context) {
    print('actionWidget:${actionWidget != null}');
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      bool isEn = state.locale.languageCode == 'en';
      return AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        titleSpacing: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: (CachHelper.lang ?? 'ar') == 'ar'
              ? 'STV'
              : GoogleFonts.poppins().fontFamily ?? 'Poppins',
          fontSize: AppSize.font(24),
          fontWeight: FontWeight.w700,
          color: colorOfBackButton ?? AppColors.textPrimary,
        ),
        bottom: bottom,
        title: Text(
          context.tr(title ?? ''),
          style: kTextStyle17.copyWith(
              color: colorOfTitle ?? AppColors.primary, fontSize: 24.sp),
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
                color: colorOfBackButton ?? AppColors.iconColor,
              ),
        actions: showLang == true
            ? [
                SizedBox(width: AppSize.getWidth(12)),
                const CustomChangeLang(),
                SizedBox(width: AppSize.getWidth(12)),
              ]
            : actionWidget != null
                ? [actionWidget ?? const SizedBox()]
                : null,
      );
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar ?? kToolbarHeight);
}
