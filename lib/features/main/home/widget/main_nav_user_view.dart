import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/helper/app_toast.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../controller/nav_home_cubit.dart';
import '../nav_user_view.dart';

class MainNavUserView extends StatelessWidget {
  const MainNavUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 2, color: AppColors.primary),
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Opacity(
              opacity: 1,
              child: BottomNavigationBar(
                  currentIndex: 0,
                  onTap: (page) {
                    AppNavigator.push(NavUserView(
                      index: page,
                    ));
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                            svg: AppIcons.home,
                            color: NavCubit.changeColor(0, 0)),
                        label: "navHome.home".tr()),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppIcons.map,
                          color: NavCubit.changeColor(1, 0),
                        ),
                        label: "navHome.map".tr()),
                    BottomNavigationBarItem(
                        icon: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: AppColors.primary,
                            child: CustomSvg(svg: AppSvg.plus)),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppIcons.chatFilled,
                          color: NavCubit.changeColor(3, 0),
                        ),
                        label: "navHome.chat".tr()),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppIcons.profile,
                          color: NavCubit.changeColor(4, 0),
                        ),
                        label: "navHome.profile".tr()),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
