import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_assets.dart';
import '../../../core/shared/widgets/custom_svg.dart';
import '../controller/nav_home_cubit.dart';

class NavDriverView extends StatelessWidget {
  final int? index;

  const NavDriverView({super.key, this.index});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(index: index),
      child: BlocBuilder<NavCubit, int>(builder: (context, currentIndex) {
        final cubit = context.read<NavCubit>();
        return Scaffold(
            bottomNavigationBar:
                Column(mainAxisSize: MainAxisSize.min, children: [
              Divider(height: 1, thickness: 2, color: AppColors.primaryDriver),
              BottomNavigationBar(
                  selectedItemColor: AppColors.primaryDriver,
                  currentIndex: currentIndex,
                  onTap: (page) {
                    cubit.changePage(page);
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                            svg: AppIcons.home,
                            color:
                                NavCubit.changeColorForDriver(0, currentIndex)),
                        label: "navHome.home".tr()),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppSvg.delivery,
                          color: NavCubit.changeColorForDriver(1, currentIndex),
                        ),
                        label: "my orders".tr()),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppIcons.chatFilled,
                          color: NavCubit.changeColorForDriver(2, currentIndex),
                        ),
                        label: "navHome.chat".tr()),
                    BottomNavigationBarItem(
                        icon: CustomSvg(
                          svg: AppIcons.profile,
                          color: NavCubit.changeColorForDriver(3, currentIndex),
                        ),
                        label: "navHome.profile".tr()),
                  ]),
            ]),
            body: cubit.tabsOfDriver[currentIndex]);
      }),
    );
  }
}
