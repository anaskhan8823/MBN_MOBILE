import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/app_toast.dart';
import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../helper/app_navigator.dart';

part 'theme_state.dart';
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(CachHelper.theme == 'dark' ? ThemeMode.dark : ThemeMode.light));
  bool get isDark => CachHelper.theme == 'dark';
  void changeThemeMode() async{
    String newTheme = CachHelper.theme == 'dark' ? 'light' : 'dark';
    CachHelper.theme = newTheme;
    await CachHelper.saveData();
    emit(ThemeState(newTheme == 'dark' ? ThemeMode.dark : ThemeMode.light));
  }
  void restartApplication() {
    AppToast.success("theme change successfully to ${CachHelper.theme}");
    AppNavigator.remove(const NavUserView());
  }
  void setTheme(bool isDarkMode) {
    String newTheme = isDarkMode ? 'dark' : 'light';
    CachHelper.theme = newTheme;
    emit(ThemeState(isDarkMode ? ThemeMode.dark : ThemeMode.light));
  }

}

class ThemeChangeObserver extends WidgetsBindingObserver {
  final VoidCallback onThemeChanged;

  ThemeChangeObserver(this.onThemeChanged);

  @override
  void didChangePlatformBrightness() {
    onThemeChanged();
  }
}

