import 'dart:developer';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/language/cubit/language_cubit.dart';
import 'core/dio_helper.dart';
import 'core/helper/app_navigator.dart';
import 'core/style/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// SHARED PREFERENCES INIT
  await CachHelper.init();

  /// LANGUAGE INIT
  await EasyLocalization.ensureInitialized();
  // await AppLocales.init();
  // NOTIFICATIONS
  // await FirebaseNotifications.initialize();
  // await LocalNotificationService.initialize();

  // /// SOCKET IO INIT
  // await SocketService().initialize();

  // /// SET DISABLE AUTO ROTATE
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  // );
  await ScreenUtil.ensureScreenSize();

  /// API INIT [DIO]
  DioHelper.interceptors();
  final themeObserver = ThemeChangeObserver(() {
    log("تم تغيير الثيم!");
  });
  WidgetsBinding.instance.addObserver(themeObserver);
  final String defLang = CachHelper.lang ?? 'ar';
  final Brightness platFormBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  final bool isDark = (CachHelper.theme != null)
      ? CachHelper.theme == 'dark'
      : platFormBrightness == Brightness.dark;
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      startLocale: Locale(defLang),
      fallbackLocale: const Locale('en'),
      supportedLocales: const [Locale('en'), Locale('ar')],
      child: MyApp(
        isDark: isDark,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => ThemeCubit()..setTheme(isDark)),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              bool isDark = CachHelper.theme == 'dark';
              return ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) => MaterialApp(
                  themeMode: themeState.mode,
                  key: Key('${state.locale}_${themeState.mode}'),
                  theme: isDark ? AppTheme.dark : AppTheme.light,
                  locale: state.locale,
                  title: 'Dalil 2020',
                  darkTheme: isDark == true ? AppTheme.dark : AppTheme.light,
                  home: Utils.getUser,
                  navigatorKey: AppNavigator.key,
                  debugShowCheckedModeBanner: false,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
