import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../constans.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../add_product/view.dart';
import '../../controller/nav_home_cubit.dart';
import '../nav_productive_families_view.dart';

class MainNavProductiveView extends StatelessWidget {
  const MainNavProductiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Divider(height: 1, thickness: 2, color: AppColors.primaryProductive),
      BottomNavigationBar(
          selectedItemColor: AppColors.primaryProductive,
          currentIndex: 0,
          onTap: (page) {
            AppNavigator.push(NavProductiveView(
              index: page,
            ));
          },
          items: [
            BottomNavigationBarItem(
                icon: CustomSvg(
                    svg: AppIcons.home,
                    color: NavCubit.changeColorForProductive(0, 0)),
                label: "navHome.home".tr()),
            BottomNavigationBarItem(
                icon: CustomSvg(
                  svg: AppSvg.myStores,
                  color: NavCubit.changeColorForProductive(1, 0),
                ),
                label: "homeProductive.myProducts".tr()),
            BottomNavigationBarItem(
                icon: FloatingActionButton(
                    onPressed: () {
                      AppNavigator.push(const AddProduct(
                        storeId: null,
                        enterScreen: kProductiveFamilies,
                      ));
                    },
                    backgroundColor: AppColors.primaryProductive,
                    child: CustomSvg(svg: AppSvg.plus)),
                label: ""),
            BottomNavigationBarItem(
                icon: CustomSvg(
                  svg: AppIcons.chatFilled,
                  color: NavCubit.changeColorForProductive(3, 0),
                ),
                label: "navHome.chat".tr()),
            BottomNavigationBarItem(
                icon: CustomSvg(
                  svg: AppIcons.profile,
                  color: NavCubit.changeColorForProductive(4, 0),
                ),
                label: "navHome.profile".tr()),
          ]),
    ]);
  }
}
