import 'dart:convert';
import 'package:dalil_2020_app/models/onboardin_screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/cache/cache_keys.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/login/view.dart';
import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';

class OnBoardingApiScreen extends StatefulWidget {
  const OnBoardingApiScreen({super.key});

  @override
  State<OnBoardingApiScreen> createState() => _OnBoardingApiScreenState();
}

class _OnBoardingApiScreenState extends State<OnBoardingApiScreen> {
  List<OnBoardingItem> items = [];
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchOnBoardingItems();
  }

  Future<void> fetchOnBoardingItems() async {
    final response = await http.get(
      Uri.parse('https://filterr.net/api/v1/sliders/splash?platform=mobile'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      setState(() {
        items = data.map((e) => OnBoardingItem.fromJson(e)).toList();
      });
    }
  }

  Future<void> finishOnboarding() async {
    await CachHelper.prefs.setBool(CacheKeys.onboardingDone, true);
    AppNavigator.replace(
      CachHelper.isAuth ? NavUserView() : SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.network(
                      items[index].image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                ),

                /// PAGE INDICATOR (top or bottom overlay)
                Positioned(
                  bottom: 80,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      items.length,
                      (index) => Container(
                        margin: const EdgeInsets.all(4),
                        width: currentIndex == index ? 12 : 8,
                        height: currentIndex == index ? 12 : 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.orange
                              : Colors.white70,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),

                /// SKIP / START BUTTON (bottom right overlay)
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: finishOnboarding,
                    child: Icon(
                      currentIndex == items.length - 1
                          ? Icons.check
                          : Icons.arrow_forward,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

                /// OPTIONAL: skip text
                Positioned(
                  bottom: 28,
                  left: 20,
                  child: TextButton(
                    onPressed: finishOnboarding,
                    child: Text(
                      currentIndex == items.length - 1
                          ? ""
                          : "تخطى", // skip text in Arabic
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
