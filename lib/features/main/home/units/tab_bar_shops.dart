import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shop_owner_details/my_stores.dart';
import '../components/home_user/control/home_user_cubit.dart';

class TabBarShops extends StatelessWidget {
  const TabBarShops({super.key});

  @override
  Widget build(BuildContext context) {
    final isEn = context.locale.languageCode == 'en';
    return DefaultTabController(
      length: 3,
      child: Column(
        spacing: 10,
        children: [
          TabBar(
              unselectedLabelColor: AppColors.labelInputColor,
              labelColor: AppColors.primary,
              indicatorColor: AppColors.primary,
              dividerColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              tabAlignment: isEn ? TabAlignment.center : TabAlignment.fill,
              onTap: (index) {
                context.read<HomeUserCubit>().updateIndexTap(index);
              },
              tabs: [
                Tab(
                  child: Text('homeShopOwner.mostVisited'.tr(),
                      style: kTextStyle14WhiteAndBlack),
                ),
                Tab(
                  child: Text('homeShopOwner.featured'.tr(),
                      style: kTextStyle14WhiteAndBlack),
                ),
                Tab(
                  child: Text('homeShopOwner.highestRated'.tr(),
                      style: kTextStyle14WhiteAndBlack.copyWith(
                          fontSize: AppSize.font(13))),
                ),
              ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: const TabBarView(
              children: [
                MyStores(homeOfUser: true, indexOfTap: 0),
                MyStores(homeOfUser: true, indexOfTap: 1),
                MyStores(homeOfUser: true, indexOfTap: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
