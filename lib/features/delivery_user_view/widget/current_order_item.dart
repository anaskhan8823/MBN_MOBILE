import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';
import '../../../core/helper/app_navigator.dart';
import '../../widgets/custom_user_profile_image.dart';
import '../home_delivery_user/data/enum/order_state_enum.dart';
import '../home_delivery_user/data/model/order_state_model.dart';
import '../order_details/data/repo/order_details_repo_impel.dart';
import '../order_details/presentation/controller/order_details_cubit.dart';
import '../order_details/presentation/view/order_details_screen.dart';

class CurrentOrderItem extends StatelessWidget {
  const CurrentOrderItem({super.key, required this.data});
  final OrderStateModel data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryDriver),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 55,
                height: 55,
                child: CustomUserProfileImage(
                  color: AppColors.primaryDriver,
                  url: data.avatar,
                )),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(data.username ?? '',
                    style: kTextStyle16Orange.copyWith(
                        color: AppColors.whiteAndBlackColor, fontSize: 12.sp)),
                const SizedBox(height: 5),
                Expanded(
                  child: SizedBox(
                    width: AppSize.getWidth(170),
                    child: Text.rich(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      TextSpan(
                        text: "${context.tr('deliveryUserView.address')}: ",
                        style: kTextStyle10Amber.copyWith(
                          color: AppColors.primaryDriver,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.sp,
                        ),
                        children: [
                          TextSpan(
                            text: data.address ?? '',
                            style: TextStyle(
                                color: AppColors.inputPlaceholderDark,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(capitalize(data.status),
                    style: kTextStyle10Amber.copyWith(
                        color: (data.status == OrderStateEnum.confirmed.key)
                            ? AppColors.iconSuccess
                            : (data.status == OrderStateEnum.canceled.key)
                                ? AppColors.errorBorderLight
                                : null)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    onPressed: () {
                      AppNavigator.push(BlocProvider(
                          create: (_) => OrdersDetailsCubit(
                              orderDetailsRepo: OrderDetailsRepoImpel(),
                              orderData: data)
                            ..getOrderDetails(),
                          child: OrderDetailsScreen()));
                    },
                    child: Text(context.tr('deliveryUserView.showDetails'),
                        style: kTextStyle10Amber.copyWith(
                            color: AppColors.blackAndWhiteColor)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String capitalize(String? s) {
    if (s == null) return '';
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
