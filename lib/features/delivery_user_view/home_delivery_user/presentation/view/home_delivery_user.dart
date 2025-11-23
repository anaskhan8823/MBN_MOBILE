import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

import '../../../../../core/app_assets.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../main/controller/nav_home_cubit.dart';
import '../../../../main/home/units/custom_slider.dart';
import '../../../../widgets/custom_drawer.dart';
import '../../../widget/current_order_item.dart';
import '../../../widget/see_more_for_delivery.dart';
import '../../data/enum/request_state_enum.dart';
import '../controller/orders_cubit.dart';

class HomeDeliveryUserScreen extends StatelessWidget {
  HomeDeliveryUserScreen({super.key});
  final ScrollController paginationScrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData appMediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size(appMediaQueryData.size.width, AppSize.getHeight(80)),
          child: Container(
            padding: appMediaQueryData.padding.copyWith(left: 10, right: 30),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.textLabelSelected,
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: SvgPicture.asset(
                          AppIcons.menu,
                          color: AppColors.textLabelSelected,
                        )),
                    SizedBox(width: AppSize.getWidth(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.tr('deliveryUserView.hiThere'),
                          style: kTextStyle13,
                        ),
                        Text(
                          CachHelper.userName ?? '',
                          style: kTextStyle18.copyWith(
                              color: AppColors.textLabelSelected),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                CachedNetworkImage(
                    imageUrl: CachHelper.image?.toString() ?? '',
                    placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: AppSize.getWidth(65),
                        height: AppSize.getHeight(65),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.textLabelSelected, width: 1),
                          image: DecorationImage(
                            image: imageProvider,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        width: AppSize.getWidth(65),
                        height: AppSize.getHeight(65),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.textLabelSelected, width: 1),
                          image: DecorationImage(
                              image: AssetImage(AppIcons.choosePhoto),
                              fit: BoxFit.fitWidth),
                        ),
                      );
                    }),
              ],
            ),
          )),
      drawer: CustomDrawer(
        color: AppColors.primaryDriver,
      ),
      key: _scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 15,
          ),
          CustomSliderItem(color: AppColors.primaryDriver),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SeeMoreForDelivery(
                  mainText: context.tr('deliveryUserView.currentOrders'),
                  onPressed: () {
                    context.read<NavCubit>().changePage(1);
                  },
                  color: AppColors.primaryDriver,
                  seeColor: AppColors.isDark() ? Colors.white : Colors.black,
                ),
                BlocBuilder<OrdersCubit, OrdersInitial>(
                    builder: (context, currentIndex) {
                  final cubit = context.read<OrdersCubit>();
                  return cubit.state.requestState == RequestStateEnum.loading
                      ? const CircularProgressIndicator(
                          strokeWidth: 3,
                          color: AppColors.textLabelSelected,
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 2.3,
                          // fit: FlexFit.loose,
                          child: RefreshLoadmore(
                            onRefresh: () async {
                              await context.read<OrdersCubit>().getOrders(0);
                            },
                            onLoadmore: () async {
                              await Future.delayed(Duration(seconds: 1), () {
                                context.read<OrdersCubit>().getOrders(null);
                              });
                            },
                            isLastPage: false,
                            loadingWidget: CupertinoActivityIndicator(),
                            child: ListView.builder(
                              controller: paginationScrollController,
                              itemCount: cubit.state.ordersDataOnHome.length,
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return CurrentOrderItem(
                                  data: cubit.state.ordersDataOnHome[index],
                                );
                              },
                            ),
                          ),
                        );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
