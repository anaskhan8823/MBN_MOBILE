import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../widgets/card_driver_item.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../widgets/custom_user_profile_image.dart';
import '../../controller/home_cubit/home_cubit.dart';
import '../units/custom_slider.dart';
import '../units/text_row_see_all.dart';
class HomeDriver extends StatelessWidget {
  HomeDriver({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final blue=AppColors.primaryDriver;
    return  SafeArea(
      child: BlocProvider(
        create: (_) => HomeCubit(),
        child: Scaffold(
          key: _globalKey,
          drawer: const CustomDrawer(
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, homeState) {
                    return Skeletonizer(
                      enabled: homeState is HomeLoading,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        child: GestureDetector(
                                          onTap: () =>
                                              _globalKey.currentState?.openDrawer(),
                                          child: SvgPicture.asset(
                                            AppSvg.menu,
                                            colorFilter:ColorFilter.mode(blue, BlendMode.srcIn) ,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "navHome.hi".tr(),
                                          style: kTextStyle14white.copyWith(
                                              color: AppColors.whiteAndBlackColor
                                          ),
                                        ),
                                        Text(
                                          CachHelper.userName
                                              // successLoadUserData
                                              //     ? homeState.list.profileName ?? ''
                                              ?? '',
                                          style: kTextStyle16Orange.copyWith(color: blue),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    CustomUserProfileImage(color:blue,),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Divider(
                                height: 1,
                                thickness: 2,
                                color: blue),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomSliderItem(color:blue),
                            TextSeeAll(
                              color:blue,
                              mainText: "homeProductive.myProducts",
                              onPressed: () {
                              },
                            ),
                            ListView.builder(
                              physics:const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const
                                CardDriverItem(name: "mohammed",address: "elgharbia",);
                              }
                            ),
                          ],
                        ),
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
