import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/widgets/custom_store_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/style/app_size.dart';
import '../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_user_profile_image.dart';
import '../../../widgets/empty_stores.dart';
import '../../../widgets/storeCard.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../../controller/paginate_sallers_cubit.dart';
import '../../controller/store_and_product_cubit/add_store_cubit.dart';
import '../../shop_owner_details/all_stores/view.dart';
import '../../shop_owner_details/store_details/view.dart';
import '../units/custom_slider.dart';
import '../units/details_of_user.dart';
import '../units/text_row_see_all.dart';
part '../../shop_owner_details/details_of_user.dart';
part '../../../widgets/stores_of_user.dart';

class HomeShopOwner extends StatelessWidget {
  HomeShopOwner({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => HomeCubit()..getShopOwnerSummaryDetails(),
            ),
            BlocProvider(
              create: (context) => StoreAndProductCubit()..getAllStores(),
            ),
          ],
          child: Scaffold(
            key: _globalKey,
            drawer: const CustomDrawer(),
            body: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, homeState) {
                      final bool successLoadUserData = homeState is HomeSuccess;
                      return Skeletonizer(
                          enabled: homeState is HomeLoading,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                DetailsOfShopOwnerUser(
                                  successLoadUserData: successLoadUserData,
                                  homeState: homeState,
                                  onTap: () =>
                                      _globalKey.currentState?.openDrawer(),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: AppColors.primary),
                                const SizedBox(
                                  height: 20,
                                ),
                                const CustomSliderItem(),
                                TextSeeAll(
                                  showSeeAll: false,
                                  mainText: "navHome.myStores",
                                  onPressed: () {
                                    AppNavigator.push(BlocProvider.value(
                                      value:
                                          BlocProvider.of<StoreAndProductCubit>(
                                              context),
                                      child: const AllStores(
                                        hideBackButton: false,
                                      ),
                                    ));
                                  },
                                ),
                                BlocBuilder<StoreAndProductCubit,
                                        StoreAndProductState>(
                                    builder: (context, state) {
                                  return StoresOfUser(
                                    cubit: context.read<StoreAndProductCubit>(),
                                    loading: state is AddStoreLoading,
                                    success: state is GetStoresSuccess
                                        ? state
                                        : null,
                                    successLoadUserData:
                                        state is GetStoresSuccess,
                                  );
                                }),
                              ]));
                    }))
              ],
            ),
          )),
    );
  }
}
