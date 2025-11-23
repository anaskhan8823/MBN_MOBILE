import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../controller/nav_home_cubit.dart';
import '../nav_driver_view.dart';

class MainNavDriverView extends StatelessWidget {
  const MainNavDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Divider(height: 1, thickness: 2, color: AppColors.primaryDriver),
      BottomNavigationBar(
          selectedItemColor: AppColors.primaryDriver,
          currentIndex: 0,
          onTap: (page) {
            AppNavigator.push(NavDriverView(
              index: page,
            ));
          },
          items: [
            BottomNavigationBarItem(
                icon: CustomSvg(
                    svg: AppIcons.home,
                    color: NavCubit.changeColorForDriver(0, 0)),
                label: "navHome.home".tr()),
            BottomNavigationBarItem(
                icon: CustomSvg(
                  svg: AppSvg.delivery,
                  color: NavCubit.changeColorForDriver(1, 0),
                ),
                label: "my orders".tr()),
            BottomNavigationBarItem(
                icon: CustomSvg(
                  svg: AppIcons.chatFilled,
                  color: NavCubit.changeColorForDriver(2, 0),
                ),
                label: "navHome.chat".tr()),
            BottomNavigationBarItem(
                icon: CustomSvg(
                  svg: AppIcons.profile,
                  color: NavCubit.changeColorForDriver(3, 0),
                ),
                label: "navHome.profile".tr()),
          ]),
    ]);
  }
}
