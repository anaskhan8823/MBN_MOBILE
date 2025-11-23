import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:flutter/material.dart';

class AppColors {
  ///TODO: REMOVE THIS
  static bool isDark() => CachHelper.theme == 'dark';
  // static bool isDark() => CacheHelper.get('theme') == 'dark';

  static Color shimmerLoading() {
    bool isDark = CachHelper.theme == 'dark';
    return isDark
        ? Colors.white.withValues(alpha: 0.25)
        : Colors.black.withValues(alpha: 0.25);
  }

  ///Text Colors
  static const Color transparent = Colors.transparent;
  static const Color textGrayDark = Color(0xffC0C1C4);
  static const Color textGrayLight = Color(0xffA5A5A5);

  static const Color textDark = Color(0xffffffff);
  static const Color textLight = Colors.grey;

  static const Color containerBackDark = Color(0xffFFFBF4);
  static const Color containerBackLight = Colors.black;

  static const Color errorBorderLight = Color(0xffFF2028);
  static const Color errorBorderDark = Color(0xffFF2028);

  // Shared Colors
  static const Color primaryLight = Color(0xffFDB133);
  static const Color primaryDark = Color(0xffFDB133);
  static const Color secondaryLight = Color(0xff314768);
  static const Color secondaryDark = Color(0xff314768);
  static const Color tertiaryLight = Color(0xff213047);
  static const Color tertiaryDark = Color(0xff213047);
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);

  // Splash bg
  static const Color splashBackgroundLight = Color(0xff213047);
  static const Color splashBackgroundDark = Color(0xff212F46);

  // Background Colors
  static const Color backgroundPrimaryLight = Color(0xffFAFAFA);
  static const Color backgroundPrimaryDark = Color(0xff020308);
  static const Color backgroundSecondaryLight = Color(0xffffffff);
  static const Color backgroundSecondaryDark = Color(0xff1E2327);
  static const Color backgroundTertiaryLight = Color(0xff213047);
  static const Color backgroundTertiaryDark = Color(0xff1E2327);

  // Typography Colors
  static const Color typographyHeadingLight = Color(0xff100B0B);
  static const Color typographyHeadingDark = Color(0xffF6F6F6);
  static const Color typographySubtitleLight = Color(0xff656565);
  static const Color typographySubtitleDark = Color(0xffC5C7C5);
  static const Color typographyBodyLight = Color(0xff30303D);
  static const Color typographyBodyDark = Color(0xffB3BAC6);

  // Button Colors
  static const Color buttonPrimaryLight = Color(0xffFDB133);
  static const Color buttonPrimaryDark = Color(0xffFDB133);
  static const Color buttonSecondaryLight = Color(0xff213047);
  static const Color buttonSecondaryDark = Color(0xff213047);
  static const Color buttonLabelLight = Color(0xffFFFFFF);
  static const Color buttonLabelDark = AppColors.primaryDark;
  static const Color buttonOutlineLight = Color(0xffC79C6B);
  static const Color buttonOutlineDark = Color(0xff222125);
  static const Color buttonDisabled = Color(0xffCCCCCC);

  // Icon Colors
  static const Color iconPrimaryLight = Color(0xff17263C);
  static const Color iconPrimaryDark = Color(0xffD6D9E1);
  static const Color iconSuccess = Color(0xff039754);
  static const Color iconGray = Color(0xff8A8A8A);
  static const Color iconWarning = Color(0xffB07B1D);
  static const Color iconDanger = Color(0xffD3272F);
//textColor
  static const Color textLabelight = Color(0xffFFFFFF);
  static const Color textLabeDark = Color(0xff222125);
  static const Color textLabelSelected = Color(0xff249AD2);
  static const Color textLabelUnSelected = Color(0xffC1C2C3);

  // Input Colors
  static const Color inputBackgroundLight = Color(0xc5fffdf9);
  static const Color inputBackgroundDark = Colors.grey;
  static const Color inputPlaceholderLight = Color(0xff656565);
  static const Color inputPlaceholderDark = Color(0xffB3BAC6);
  static const Color inputOutlineLight = Color(0xffE0E8EC);
  static const Color inputOutlineDark = Color(0xff191B22);

  // Separating Colors
  static const Color separatingPrimaryBorderLight = Color(0xffE0E8EC);
  static const Color separatingPrimaryBorderDark = Color(0xff3C4350);
  static const Color separatingSecondaryBorderLight = Color(0xffC79C6B);
  static const Color separatingSecondaryBorderDark = Color(0xffC79C6B);
  static const Color separatingSeparatorLight = Color(0xffE7E7E7);
  static const Color separatingSeparatorDark = Color(0xff181D1F);

  //COLORS I ADDED

  static const Color textWarning = Color(0xffD2B089);
  static const Color notificationColor = Color(0xffCC2F61);

  // Getters for dynamic colors based on theme
  static Color get textPrimary => isDark() ? textDark : textLight;

  static Color get textGrey => isDark() ? textGrayDark : textGrayLight;

  static Color get containerBack =>
      isDark() ? containerBackDark : Colors.grey.shade100;
  static Color get containerBackUserType =>
      isDark() ? containerBackDark : Colors.grey.shade900;
  static Color get containerPhotoBack =>
      isDark() ? containerBackDark : const Color(0xffEFEFEF);

  static Color get primary => isDark() ? primaryDark : primaryLight;
  static Color get backButton =>
      isDark() ? textLabelSelected : textLabelSelected;
  static Color get primaryProductive =>
      isDark() ? const Color(0xffFA898F) : const Color(0xffFA898F);
  static Color get primaryDriver =>
      isDark() ? const Color(0xff249AD2) : const Color(0xff249AD2);

  static Color get splashBackground =>
      isDark() ? splashBackgroundDark : splashBackgroundLight;

  static Color get backgroundPrimary =>
      isDark() ? backgroundPrimaryDark : backgroundPrimaryLight;

  static Color get backgroundSecondary =>
      isDark() ? backgroundSecondaryDark : backgroundSecondaryLight;

  static Color get backgroundTertiary =>
      isDark() ? backgroundTertiaryDark : backgroundTertiaryLight;

  static Color get typographyHeading =>
      isDark() ? typographyHeadingDark : typographyHeadingLight;

  static Color get typographySubtitle =>
      isDark() ? typographySubtitleDark : typographySubtitleLight;

  static Color get typographyBody =>
      isDark() ? typographyBodyDark : typographyBodyLight;

  static Color get buttonPrimary =>
      isDark() ? buttonPrimaryDark : buttonPrimaryLight;
  static Color get buttonSecondary =>
      isDark() ? buttonSecondaryDark : buttonSecondaryLight;

  static Color get buttonLabel => isDark() ? buttonLabelDark : buttonLabelLight;
  static Color get textColor => isDark() ? textLabelight : textLabeDark;

  static Color get buttonOutline =>
      isDark() ? buttonOutlineDark : buttonOutlineLight;

  static Color get iconPrimary => isDark() ? iconPrimaryDark : iconPrimaryLight;
  static Color get iconPrimaryOfTheme =>
      isDark() ? iconPrimaryDark : buttonPrimaryLight;
  static Color get iconPrimaryOfTheme2 =>
      isDark() ? buttonPrimaryLight : iconPrimaryDark;

  ///dropButtonColors
  static Color get dropButtonColor =>
      isDark() ? Colors.grey.shade900 : inputBackgroundLight;

  static Color get dropButtonTextColor =>
      isDark() ? AppColors.white : AppColors.black;

  static Color get dropButtonIconColor =>
      isDark() ? AppColors.white : AppColors.black;

  static Color get iconColor => isDark() ? AppColors.white : AppColors.primary;

  static Color get labelInputColor =>
      isDark() ? AppColors.white : AppColors.black;

  static Color get borderContainerColor =>
      isDark() ? AppColors.transparent : AppColors.primary;
  static Color get borderContainerColorProductive =>
      isDark() ? AppColors.transparent : AppColors.primaryProductive;

  static Color get textButtonsColor => isDark() ? Colors.black : Colors.white;
  static Color get blackAndWhiteColor => isDark() ? Colors.black : Colors.white;
  static Color get whiteAndBlackColor => isDark() ? Colors.white : Colors.black;
  static Color get whiteAndOrangeColor =>
      isDark() ? Colors.white : AppColors.primary;
  static Color get whiteAndPinkColor =>
      isDark() ? Colors.white : AppColors.primaryProductive;
  static Color get greyAndWhiteWithShadowColor =>
      isDark() ? Colors.black : const Color(0xffFFFDF9);
  static Color get greyAndWhiteWithColor =>
      isDark() ? Colors.grey.shade900 : const Color(0xffFFFDF9);
  static Color get whiteAndGreyColor => isDark() ? Colors.white70 : Colors.grey;
  static Color get transparentAndGreyColor =>
      isDark() ? Colors.transparent : Colors.grey.shade300;
  static Color get blackAndGreyColor =>
      isDark() ? Colors.black : Colors.grey.shade300;

  static Color get navBarTextColor => isDark() ? Colors.white : Colors.grey;
  static Color get underlineColor =>
      isDark() ? Colors.white : AppColors.primary;
  static Color get inputPlaceholder =>
      isDark() ? inputPlaceholderDark : inputPlaceholderLight;

  static Color get inputOutline =>
      isDark() ? inputOutlineDark : inputOutlineLight;

  static Color get separatingPrimaryBorder =>
      isDark() ? separatingPrimaryBorderDark : separatingPrimaryBorderLight;

  static Color get separatingSecondaryBorder =>
      isDark() ? separatingSecondaryBorderDark : separatingSecondaryBorderLight;

  static Color get separatingSeparator =>
      isDark() ? separatingSeparatorDark : separatingSeparatorLight;
}
