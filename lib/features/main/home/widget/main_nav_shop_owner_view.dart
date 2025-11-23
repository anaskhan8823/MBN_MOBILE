import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../controller/nav_home_cubit.dart';
import '../../shop_owner_details/add_store/nav_and_stepper_add_store.dart';
import '../nav_shop_owner_view.dart';

class MainNavShopOwnerView extends StatelessWidget {
  const MainNavShopOwnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Divider(height: 1, thickness: 2, color: AppColors.primary),
      BottomNavigationBar(
          currentIndex: 0,
          onTap: (page) {
            AppNavigator.push(NavShopOwnerView(
              index: page,
            ));
          },
          items: [
            BottomNavigationBarItem(
                icon: CustomSvg(
                    svg: AppIcons.home, color: NavCubit.changeColor(0, 0)),
                label: "navHome.home".tr()),
            BottomNavigationBarItem(
                icon: CustomSvg(
                  svg: AppSvg.myStores,
                  color: NavCubit.changeColor(1, 0),
                ),
                label: "navHome.myStores".tr()),
            BottomNavigationBarItem(
                icon: FloatingActionButton(
                    onPressed: () {
                      AppNavigator.push(const NavAddStore());
                    },
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
    ]);
  }
}
