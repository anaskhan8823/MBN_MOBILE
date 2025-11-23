import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helper/app_navigator.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/text_style.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';
import '../../../order_details/data/repo/order_details_repo_impel.dart';
import '../../../order_details/presentation/controller/order_details_cubit.dart';
import '../../../order_details/presentation/view/order_details_screen.dart';
import '../../../widget/button_widget.dart';

class AlertOfNewOrder extends StatelessWidget {
  final OrderStateModel orderData;
  AlertOfNewOrder({required this.orderData});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        context.tr('deliveryUserView.newOrder'),
        style: kTextStyle16Orange.copyWith(color: AppColors.textLabelSelected),
        textAlign: TextAlign.center,
      ),
      content: Text(
        context.tr('deliveryUserView.newOrder2'),
        style: kTextStyle16white.copyWith(
            color:
                AppColors.isDark() ? AppColors.white : AppColors.textGrayLight),
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ButtonWidget(
                height: 45.h,
                width: MediaQuery.of(context).size.width / 2,
                backgroundColor: AppColors.textLabelSelected,
                borderColor: AppColors.textLabelSelected,
                borderWidth: 1,
                borderRadius: 50,
                onPressed: () async {
                  Navigator.of(context).pop();

                  AppNavigator.push(BlocProvider(
                      create: (_) => OrdersDetailsCubit(
                          orderDetailsRepo: OrderDetailsRepoImpel(),
                          orderData: orderData)
                        ..getOrderDetails(),
                      child: OrderDetailsScreen()));
                },
                body: Text(context.tr('deliveryUserView.orderDetails'),
                    style: kTextStyle16white.copyWith(
                        color: AppColors.isDark()
                            ? AppColors.black
                            : AppColors.white)),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ButtonWidget(
                height: 45.h,
                width: MediaQuery.of(context).size.width / 2,
                backgroundColor: AppColors.isDark()
                    ? AppColors.iconPrimaryLight
                    : Colors.white,
                borderColor: AppColors.textLabelSelected,
                borderWidth: 1,
                borderRadius: 50,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                body: Text(context.tr('deliveryUserView.cancel'),
                    style: kTextStyle16white.copyWith(
                        color: AppColors.textLabelSelected)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
