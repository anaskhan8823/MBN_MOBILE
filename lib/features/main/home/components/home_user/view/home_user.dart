import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/app_assets.dart';
import '../../../../../../core/shared/widgets/custom_svg.dart';
import '../../../../../../core/style/text_style.dart';
import '../../../../../widgets/categories_view.dart';
import '../../../../../widgets/custom_drawer.dart';
import '../../../../controller/nav_home_cubit.dart';
import '../../../../user_details/all_shops/all_products_for_product_for_productive_family.dart';
import '../../../../user_details/all_shops/all_products_for_selling_and_rent.dart';
import '../../../../user_details/all_shops/view.dart';
import '../../../contact/presentation/controller/manager_chat_cubit.dart';
import '../../../map/data/repo/map_repo_impel.dart';
import '../../../map/presentation/control/map_stores_cubit.dart';
import '../../../map/presentation/view/maps.dart';
import '../../../units/add_product_service.dart';
import '../../../units/custom_slider.dart';
import '../../../units/effors_list_view.dart';
import '../../../units/searchBar.dart';
import '../../../units/tab_bar_shops.dart';
import '../../../units/text_row_see_all.dart';
import '../../map_of_home/presentation/control/map_of_home_cubit.dart';
import '../../map_of_home/presentation/view/map_of_home.dart';
import '../control/home_user_cubit.dart';
part '../../../../../widgets/custom_active_And_not_active_in_cayegories.dart';
part '../../../units/categories_item.dart';

class HomeUser extends StatelessWidget {
  HomeUser({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    bool isDark = AppColors.isDark();
    return SafeArea(
      child: Scaffold(
          drawer: const CustomDrawer(),
          key: _scaffoldKey,
          body: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.getWidth(25),
                    vertical: AppSize.getHeight(10),
                  ),
                  child: buildSearchBar(
                      () => _scaffoldKey.currentState?.openDrawer(),
                      onChanged: (val) {
                    context.read<ManagerChatCubit>().getContactFromSearch(val);
                  }),
                ),
                Divider(height: 1, thickness: 2, color: AppColors.primary),
                SizedBox(
                  height: AppSize.getHeight(18),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSize.getWidth(25)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EfforsList(),
                      SizedBox(
                        height: AppSize.getHeight(16),
                      ),
                      const CustomSliderItem(),
                      SizedBox(height: AppSize.getHeight(20)),
                      Padding(
                        padding: EdgeInsets.only(left: AppSize.getWidth(14)),
                        child: TextSeeAll(
                          mainText: "homeShopOwner.Categories",
                          showSeeAll: false,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: AppSize.getHeight(20)),
                      const CategoriesItems(),
                      SizedBox(height: AppSize.getHeight(16)),
                      CustomActiveAndNotActiveInCategories(
                        svg: AppIcons.productiveFamilies,
                        title: "homeShopOwner.productive",
                        borderColor: const Color(0xffFFC2C8),
                        color: const Color(0xffef7a85),
                        screen: AllProductsForProductForProductiveFamily(),
                      ),
                      SizedBox(height: AppSize.getHeight(20)),
                      SvgPicture.asset(
                        AppIcons.wave,
                      ),
                      SizedBox(height: AppSize.getHeight(9)),
                      BlocProvider(
                          create: (_) => HomeUserCubit()..updateIndexTap(0),
                          child: const TabBarShops()),
                      SizedBox(height: AppSize.getHeight(16)),
                      SvgPicture.asset(
                        AppIcons.wave,
                      ),
                      TextSeeAll(
                        mainText: "homeShopOwner.nearbyServices",
                        onPressed: () {
                          context.read<NavCubit>().changePage(1);
                        },
                      ),
                      Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 5,
                          ),
                        ),
                        child: BlocProvider(
                            create: (_) =>
                                MapOfHomeCubit(mapRepo: MapRepoImpel())
                                  ..getStoresList(),
                            child: MapOfHome()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextSeeAll(
                          moreDetails: false,
                          mainText: "homeShopOwner.addProduct",
                          onPressed: () {},
                          showSeeAll: false),
                      const SizedBox(
                        height: 15,
                      ),
                      AddProductService(
                        svgIcon: AppSvg.sell,
                        color: isDark
                            ? const Color(0xffEBFA6E)
                            : const Color(0xffd9e862),
                        service: "homeShopOwner.sellService",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AddProductService(
                        svgIcon: AppSvg.rent,
                        color: const Color(0xff74D778),
                        service: "homeShopOwner.rentService",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ])),
    );
  }
}
