import 'package:dalil_2020_app/constans.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_user_profile_image.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../../controller/product_cubit/product_cubit.dart';
import '../../productive_families_details/all_products/view.dart';
import '../units/custom_slider.dart';
import '../units/details_of_user.dart';
import '../units/text_row_see_all.dart';
part '../../../widgets/details_of_productive_user.dart';

class HomeProductiveFamilies extends StatelessWidget {
  HomeProductiveFamilies({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeCubit()..getProductiveDetails(),
          ),
          BlocProvider(
            create: (context) => ProductCubit()..getAllProducts(),
          ),
        ],
        child: Scaffold(
          key: _globalKey,
          drawer: CustomDrawer(
            color: AppColors.primaryProductive,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, homeState) {
                    final bool successLoadUserData =
                        homeState is HomeProductiveSuccess;
                    return Skeletonizer(
                      enabled: homeState is HomeLoading,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          DetailsOfProductiveUser(
                            successLoadUserData: successLoadUserData,
                            homeState: homeState,
                            onTap: () => _globalKey.currentState?.openDrawer(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Divider(
                              height: 1,
                              thickness: 2,
                              color: AppColors.primaryProductive),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomSliderItem(color: AppColors.primaryProductive),
                          TextSeeAll(
                            showSeeAll:
                                context.read<ProductCubit>().products.length <=
                                        4
                                    ? false
                                    : true,
                            seeColor: AppColors.whiteAndBlackColor,
                            color: AppColors.primaryProductive,
                            mainText: "homeProductive.myProducts",
                            onPressed: () {
                              AppNavigator.push(
                                  const AllProductsProductiveFamiliesView(
                                hideBackButton: false,
                              ));
                            },
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.38,
                              child: AllProductsProductiveFamiliesView(
                                hideBackButton: true,
                                padding: 0,
                                viewFromWhere: kViewFromHome,
                                showAppBar: true,
                                childAspectRatio: 3.w / 1.9.h,
                                scrollDirection: Axis.horizontal,
                                crossAxisCount: 1,
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
