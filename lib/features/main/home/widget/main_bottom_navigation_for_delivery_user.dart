import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/text_style.dart';
import '../../../delivery_user_view/bottom_navigation/presentation/view/bottom_navigation_for_delivery_user.dart';

class MaionBottomNavigationForDeliveryUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                selectedId: 0,
                idOfBottom: 0),
            _itemOfBottomNavigation(
                text: context.tr('deliveryUserView.myOrders'),
                icon: AppIcons.myOrders,
                selectedId: 0,
                idOfBottom: 1),
            _itemOfBottomNavigation(
                text: context.tr('deliveryUserView.chat'),
                icon: AppIcons.chatFilled,
                selectedId: 0,
                idOfBottom: 2),
            _itemOfBottomNavigation(
                text: context.tr('deliveryUserView.profile'),
                icon: AppIcons.profile,
                selectedId: 0,
                idOfBottom: 3),
          ],
          currentIndex: 0,
          selectedLabelStyle: kTextStyle12whiteAndBlack.copyWith(
              color: AppColors.textLabelSelected),
          selectedItemColor: AppColors.textLabelSelected,
          unselectedItemColor: AppColors.textLabelUnSelected,
          unselectedLabelStyle: kTextStyle12whiteAndBlack.copyWith(
              color: AppColors.textLabelUnSelected),
          selectedIconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: AppColors.textLabelSelected),
          unselectedIconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: AppColors.textLabelUnSelected),
          onTap: (page) {
            AppNavigator.push(BottomNavigationForDeliveryUser(
              index: page,
            ));
          },
        ));
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
