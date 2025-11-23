import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/app_assets.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../auth/presentation/widgets/custom_floating_button.dart';
import '../../../../main/controller/nav_home_cubit.dart';
import '../controller/delivery_user_view_cubit.dart';

class BottomNavigationForDeliveryUser extends StatelessWidget {
  const BottomNavigationForDeliveryUser({super.key, this.index});
  final int? index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => DeliveryUserViewCubit(context: context),
        child: BlocBuilder<DeliveryUserViewCubit, DeliveryUserViewInitial>(
            builder: (context, currentIndex) {
          return BlocProvider(
              create: (_) => NavCubit(index: index),
              child:
                  BlocBuilder<NavCubit, int>(builder: (context, currentIndex) {
                final cubit = context.read<NavCubit>();
                return Scaffold(
                  floatingActionButton: CustomFloatingButton(),
                  body: cubit.tabsOfDeliveryUser[currentIndex],
                  bottomNavigationBar: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: AppColors.textLabelSelected,
                            width: 2.0,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 5),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.transparent,
                        items: <BottomNavigationBarItem>[
                          _itemOfBottomNavigation(
                              text: context.tr('deliveryUserView.home'),
                              icon: AppIcons.home,
                              selectedId: currentIndex,
                              idOfBottom: 0),
                          _itemOfBottomNavigation(
                              text: context.tr('deliveryUserView.myOrders'),
                              icon: AppIcons.myOrders,
                              selectedId: currentIndex,
                              idOfBottom: 1),
                          _itemOfBottomNavigation(
                              text: context.tr('deliveryUserView.chat'),
                              icon: AppIcons.chatFilled,
                              selectedId: currentIndex,
                              idOfBottom: 2),
                          _itemOfBottomNavigation(
                              text: context.tr('deliveryUserView.profile'),
                              icon: AppIcons.profile,
                              selectedId: currentIndex,
                              idOfBottom: 3),
                        ],
                        currentIndex: currentIndex,
                        selectedLabelStyle: kTextStyle12whiteAndBlack.copyWith(
                            color: AppColors.textLabelSelected),
                        selectedItemColor: AppColors.textLabelSelected,
                        unselectedItemColor: AppColors.textLabelUnSelected,
                        unselectedLabelStyle: kTextStyle12whiteAndBlack
                            .copyWith(color: AppColors.textLabelUnSelected),
                        selectedIconTheme: Theme.of(context)
                            .iconTheme
                            .copyWith(color: AppColors.textLabelSelected),
                        unselectedIconTheme: Theme.of(context)
                            .iconTheme
                            .copyWith(color: AppColors.textLabelUnSelected),
                        onTap: (page) {
                          cubit.changePage(page);
                        },
                      )),
                );
              }));
        }));
  }

  BottomNavigationBarItem _itemOfBottomNavigation(
      {required String text,
      required String icon,
      required int idOfBottom,
      required int selectedId}) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          icon,
          color: idOfBottom == selectedId
              ? AppColors.textLabelSelected
              : AppColors.textLabelUnSelected,
        ),
        label: text);
  }
}
