import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

import '../../../core/style/app_colors.dart';
import '../../../core/style/app_size.dart';
import '../../widgets/custom_drop_button.dart';
import '../home_delivery_user/data/enum/order_state_enum.dart';
import '../home_delivery_user/data/enum/request_state_enum.dart';
import '../home_delivery_user/presentation/controller/orders_cubit.dart';
import '../widget/auth_appbar_delivery_user_view.dart';
import '../widget/current_order_item.dart';

class MyOrders extends StatelessWidget {
  MyOrders({super.key});
  final ScrollController paginationScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AuthAppbarDeliveryUserView(
          title: context.tr('deliveryUserView.myOrders'),
          colorOfBackButton: AppColors.backButton,
          colorOfTitle: AppColors.primaryDriver,
          showLang: false,
          hideBackButton: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 10, left: 15, right: 15, top: 10),
              child: BlocBuilder<OrdersCubit, OrdersInitial>(
                  builder: (context, currentIndex) {
                final cubit = context.read<OrdersCubit>();
                return CustomDropButton(
                  color: AppColors.primaryDriver,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.primaryDriver)),
                  dropButton: DropdownButton<OrderStateEnum>(
                    style: const TextStyle(color: Colors.white),
                    icon: const SizedBox(),
                    underline: const SizedBox(),
                    // value: cubit.selectedCategoryId,
                    hint: SizedBox(
                      width: MediaQuery.of(context).size.width - (65 * 2),
                      child: Text(
                        "     ${capitalize(cubit.state.selectedState.key)}",
                        style: TextStyle(color: AppColors.primaryDriver),
                      ),
                    ),
                    items: OrderStateEnum.values.map((OrderStateEnum items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          capitalize(items.key),
                          style: TextStyle(color: AppColors.primaryDriver),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<OrdersCubit>()
                            .submitNewState(newState: value);
                      }
                    },
                  ),
                );
              }),
            ),
          ),
          heightAppBar: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: BlocBuilder<OrdersCubit, OrdersInitial>(
              builder: (context, currentIndex) {
            final cubit = context.read<OrdersCubit>();
            return cubit.state.requestState == RequestStateEnum.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.textLabelSelected,
                    ),
                  )
                : RefreshLoadmore(
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
                    child: cubit.state.ordersData.isEmpty
                        ? Container(
                            height: 100.h,
                            alignment: Alignment.center,
                            child: Text(
                              context.tr('deliveryUserView.emptyState'),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            controller: paginationScrollController,
                            itemCount: cubit.state.ordersData.length,
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return CurrentOrderItem(
                                data: cubit.state.ordersData[index],
                              );
                            },
                          ),
                  );
          }),
        ));
  }

  String capitalize(String? s) {
    if (s == null) return '';
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
