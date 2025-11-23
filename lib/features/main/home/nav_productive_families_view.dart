import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/add_product/view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_assets.dart';
import '../../../core/helper/app_navigator.dart';
import '../../../core/shared/widgets/custom_svg.dart';
import '../../auth/presentation/widgets/custom_floating_button.dart';
import '../controller/nav_home_cubit.dart';

class NavProductiveView extends StatelessWidget {
  final int? index;

  const NavProductiveView({super.key, this.index});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(index: index),
      child: BlocBuilder<NavCubit, int>(builder: (context, currentIndex) {
        final cubit = context.read<NavCubit>();
        return Scaffold(
            floatingActionButton: CustomFloatingButton(),
            bottomNavigationBar:
                Column(mainAxisSize: MainAxisSize.min, children: [
              Divider(
                  height: 1, thickness: 2, color: AppColors.primaryProductive),
              BottomNavigationBar(
                  selectedItemColor: AppColors.primaryProductive,
                  currentIndex: currentIndex,
                  onTap: (page) {
                    cubit.changePage(page);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                            svg: AppIcons.home,
                            color: NavCubit.changeColorForProductive(
                                0, currentIndex)),
                        label: "navHome.home".tr()),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppSvg.myStores,
                          color: NavCubit.changeColorForProductive(
                              1, currentIndex),
                        ),
                        label: "homeProductive.myProducts".tr()),
                    BottomNavigationBarItem(
                        icon: FloatingActionButton(
                            onPressed: () {
                              AppNavigator.push(const AddProduct(
                                enterScreen: kProductiveFamilies,
                                storeId: null,
                              ));
                            },
                            backgroundColor: AppColors.primaryProductive,
                            child: CustomSvg(svg: AppSvg.plus)),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppIcons.chatFilled,
                          color: NavCubit.changeColorForProductive(
                              3, currentIndex),
                        ),
                        label: "navHome.chat".tr()),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppIcons.profile,
                          color: NavCubit.changeColorForProductive(
                              4, currentIndex),
                        ),
                        label: "navHome.profile".tr()),
                  ]),
            ]),
            body: cubit.tabsOfProductiveFamilies[currentIndex]);
      }),
    );
  }
}
