import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_size.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        textTheme: (CachHelper.lang ?? 'ar') == 'ar'
            ? ThemeData(fontFamily: 'STV').textTheme
            : ThemeData(fontFamily: 'Poppins').textTheme,

        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme(
          primary: AppColors.primaryLight,
          secondary: AppColors.secondaryLight,
          tertiary: AppColors.tertiaryLight,
          surface: AppColors.backgroundPrimaryLight,
          onSurface: AppColors.typographyBodyLight,
          onPrimary: AppColors.white,
          error: Colors.red,
          onError: Colors.red,
          onSecondary: AppColors.typographyBodyLight,
          brightness: Brightness.light,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xffFFFDF9),
        )),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: AppColors.black),
          filled: true,
          fillColor: const Color(0xffFFFDF9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(12)),
            borderSide: const BorderSide(color: AppColors.inputOutlineLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(12)),
            borderSide: const BorderSide(color: AppColors.inputOutlineLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(12)),
            borderSide: const BorderSide(color: AppColors.secondaryLight),
          ),
        ),
        // dialogTheme: DialogTheme(
        //   backgroundColor: AppColors.backgroundSecondaryLight,
        //   titleTextStyle: TextStyle(
        //     fontSize: AppSize.font(18),
        //     fontWeight: FontWeight.bold,
        //     color: AppColors.typographyHeadingLight,
        //   ),
        //   contentTextStyle: TextStyle(
        //     fontSize: AppSize.font(14),
        //     color: AppColors.typographyBodyLight,
        //   ),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(AppSize.getSize(24)),
        //   ),
        // ),
        checkboxTheme: CheckboxThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(6)),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (states) => const BorderSide(color: AppColors.primaryLight),
          ),
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.primaryLight
                : AppColors.inputOutlineLight,
          ),
          checkColor: WidgetStateProperty.all(AppColors.white),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          splashRadius: 24,
          visualDensity: VisualDensity.compact,
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.primaryLight
                : AppColors.inputOutlineLight,
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          visualDensity: VisualDensity.compact,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.navBarTextColor,
          selectedLabelStyle: TextStyle(
            fontSize: AppSize.font(12),
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: AppSize.font(12),
            fontWeight: FontWeight.w400,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.backgroundPrimaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.getSize(12)),
            ),
          ),
        ),
        expansionTileTheme: ExpansionTileThemeData(
          collapsedBackgroundColor: AppColors.backgroundSecondaryLight,
          backgroundColor: AppColors.backgroundSecondaryLight,
          collapsedIconColor: AppColors.typographyHeadingLight,
          iconColor: AppColors.typographyHeadingLight,
          collapsedTextColor: AppColors.typographyHeadingLight,
          textColor: AppColors.typographyHeadingLight,
          tilePadding: EdgeInsets.zero,
          childrenPadding: AppSize.padding(bottom: 12),
        ),
      );

  static ThemeData get dark => ThemeData(
        textTheme: (CachHelper.lang ?? 'ar') == 'ar'
            ? ThemeData.dark().textTheme.apply(fontFamily: 'STV')
            : ThemeData.dark().textTheme.apply(fontFamily: 'Poppins'),

        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme:(CachHelper.lang=='en')?
        // GoogleFonts.poppinsTextTheme():
        // ThemeData.dark().textTheme.apply(fontFamily:'STV'),
        colorScheme: const ColorScheme(
          primary: AppColors.primaryDark,
          secondary: AppColors.secondaryDark,
          tertiary: AppColors.tertiaryDark,
          surface: AppColors.backgroundPrimaryDark,
          onSurface: AppColors.typographyBodyDark,
          error: Colors.red,
          onError: Colors.red,
          onPrimary: AppColors.white,
          onSecondary: AppColors.typographyBodyDark,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: AppColors.white),
          filled: true,
          // isDense: true,
          // errorMaxLines: 5,
          // isCollapsed: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(16)),
            borderSide: const BorderSide(color: AppColors.inputOutlineDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(16)),
            borderSide: const BorderSide(color: AppColors.inputOutlineDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(16)),
            borderSide: const BorderSide(color: AppColors.secondaryDark),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(16)),
            borderSide: const BorderSide(color: AppColors.errorBorderDark),
          ),
        ),
        // dialogTheme: DialogTheme(
        //   backgroundColor: AppColors.backgroundSecondaryDark,
        //   titleTextStyle: TextStyle(
        //     fontSize: AppSize.font(18),
        //     fontWeight: FontWeight.bold,
        //     color: AppColors.typographyHeadingDark,
        //   ),
        //   contentTextStyle: TextStyle(
        //     fontSize: AppSize.font(14),
        //     color: AppColors.typographyBodyDark,
        //   ),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(AppSize.getSize(24)),
        //   ),
        // ),
        checkboxTheme: CheckboxThemeData(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.getSize(4)),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(color: AppColors.textPrimary),
          ),
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.textPrimary
                : AppColors.textPrimary,
          ),
          checkColor: WidgetStateProperty.all(AppColors.white),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          splashRadius: 24,
          visualDensity: VisualDensity.compact,
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? AppColors.primaryDark
                : AppColors.inputOutlineDark,
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          visualDensity: VisualDensity.compact,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.navBarTextColor,
            selectedLabelStyle: TextStyle(
              fontSize: AppSize.font(12),
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: AppSize.font(12),
              fontWeight: FontWeight.w400,
            )),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.backgroundPrimaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSize.getSize(12)),
            ),
          ),
        ),
        dropdownMenuTheme: DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900],
        )),
        expansionTileTheme: ExpansionTileThemeData(
          collapsedBackgroundColor: AppColors.backgroundSecondaryDark,
          backgroundColor: AppColors.backgroundSecondaryDark,
          collapsedIconColor: AppColors.typographyHeadingDark,
          iconColor: AppColors.typographyHeadingDark,
          collapsedTextColor: AppColors.typographyHeadingDark,
          textColor: AppColors.typographyHeadingDark,
          tilePadding: EdgeInsets.zero,
          childrenPadding: AppSize.padding(bottom: 12),
        ),
      );
}
