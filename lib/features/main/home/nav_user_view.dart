import 'dart:ui';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constans.dart';
import '../../../core/app_assets.dart';
import '../../../core/cache/cache_helper.dart';
import '../../../core/helper/app_navigator.dart';
import '../../../core/helper/app_toast.dart';
import '../../../core/shared/widgets/custom_svg.dart';
import '../../auth/presentation/widgets/custom_floating_button.dart';
import '../add_product/view.dart';
import '../controller/nav_home_cubit.dart';
import '../shop_owner_details/add_store/nav_and_stepper_add_store.dart';

class NavUserView extends StatelessWidget {
  final int? index;
  const NavUserView({super.key, this.index});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(index: index),
      child: BlocBuilder<NavCubit, int>(builder: (context, currentIndex) {
        final cubit = context.read<NavCubit>();
        return Scaffold(
            // extendBody: true,

            floatingActionButton: CustomFloatingButton(),
            backgroundColor: AppColors.isDark() ? Colors.black : Colors.white,
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(height: 1, thickness: 2, color: AppColors.primary),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Opacity(
                      opacity: 1,
                      child: BottomNavigationBar(
                          currentIndex: currentIndex,
                          onTap: (page) {
                            bool isAuth = CachHelper.isAuth;
                            if (isAuth == true) {
                              cubit.changePage(page);
                            } else if (isAuth == false &&
                                ((page == 2) || (page == 3))) {
                              AppToast.error(
                                  context.tr('choose_account.need_to_login'));
                            } else {
                              cubit.changePage(page);
                            }
                          },
                          items: [
                            BottomNavigationBarItem(
                                icon: CustomSvg(
                                    svg: AppIcons.home,
                                    color:
                                        NavCubit.changeColor(0, currentIndex)),
                                label: "navHome.home".tr()),
                            BottomNavigationBarItem(
                                icon: CustomSvg(
                                  svg: AppIcons.map,
                                  color: NavCubit.changeColor(1, currentIndex),
                                ),
                                label: "navHome.map".tr()),
                            BottomNavigationBarItem(
                                icon: FloatingActionButton(
                                    onPressed: () {
                                      bool isAuth = CachHelper.isAuth;
                                      if (isAuth == false) {
                                        AppToast.error(context.tr(
                                            'choose_account.need_to_login'));
                                        return;
                                      }
                                      AppNavigator.push(const AddProduct(
                                        enterScreen: kUser,
                                        storeId: null,
                                      ));
                                    },
                                    backgroundColor: AppColors.primary,
                                    child: CustomSvg(svg: AppSvg.plus)),
                                label: ""),
                            BottomNavigationBarItem(
                                icon: CustomSvg(
                                  svg: AppIcons.chatFilled,
                                  color: NavCubit.changeColor(3, currentIndex),
                                ),
                                label: "navHome.chat".tr()),
                            BottomNavigationBarItem(
                                icon: CustomSvg(
                                  svg: AppIcons.profile,
                                  color: NavCubit.changeColor(4, currentIndex),
                                ),
                                label: "navHome.profile".tr()),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            body: cubit.tabsOfUser[currentIndex]);
      }),
    );
  }
}
