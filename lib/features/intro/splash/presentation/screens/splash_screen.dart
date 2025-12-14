import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/cache/cache_keys.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/login/view.dart';
import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/helper/app_navigator.dart';
import '../../../../../core/shared/features/user/controllers/user_cubit.dart';
import '../../../../../models/user_model.dart';
import '../../../on_boarding/presentation/screens/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnState();
  }

  Future<void> _navigateBasedOnState() async {
    await Future.delayed(const Duration(seconds: 3));

    final bool onboardingDone =
        CachHelper.prefs.getBool(CacheKeys.onboardingDone) ?? false;

    if (!onboardingDone) {
      /// FIRST TIME → VIDEO
      AppNavigator.remove(const OnBoardingScreen());
    } else {
      /// NOT FIRST TIME
      AppNavigator.remove(
        CachHelper.isAuth ? NavUserView() : SignInScreen(),
      );
    }
  }

  Future<UserModel?> getUser() async {
    final userCubit = UserCubit.get(context);

    /// TODO: GET USER DATA
    // await userCubit.getUser();
    return userCubit.user;
  }

  bool checkUserAuth() {
    final ctx = AppNavigator.key.currentContext;
    return UserCubit.get(ctx!).user != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Lottie.asset(
        AppJsons.splash,
        fit: BoxFit.fill,
      ),
    );
  }
}
