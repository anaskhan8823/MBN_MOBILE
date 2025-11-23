import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/app_assets.dart';
import '../../../../../core/helper/app_navigator.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../../../chat/data/repo/chat_repo_impel.dart';
import '../../../chat/presentation/controller/chat_cubit.dart';
import '../../../chat/presentation/view/chat_screen.dart';
import '../../../home_delivery_user/data/enum/order_state_enum.dart';
import '../../../home_delivery_user/data/enum/request_state_enum.dart';
import '../../../widget/auth_appbar_delivery_user_view.dart';
import '../../../widget/button_widget.dart';
import '../controller/order_details_cubit.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppbarDeliveryUserView(
        title: context.tr('deliveryUserView.orderDetails'),
        colorOfBackButton: AppColors.backButton,
        colorOfTitle: AppColors.primaryDriver,
        showLang: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: BlocBuilder<OrdersDetailsCubit, OrderDetailsInitial>(
              builder: (context, currentIndex) {
            final cubit = context.read<OrdersDetailsCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                            imageUrl: cubit.state.orderData.avatar ?? '',
                            placeholder: (context, url) => const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: AppSize.getWidth(48),
                                height: AppSize.getHeight(48),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.textLabelSelected,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(16),
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
                                  border: Border.all(
                                      color: AppColors.textLabelSelected,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(AppIcons.choosePhoto),
                                      fit: BoxFit.fitWidth),
                                ),
                              );
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          cubit.state.orderData.username ?? '',
                          style: kTextStyle18.copyWith(
                              color: AppColors.textLabelSelected),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.tr('deliveryUserView.status'),
                          style: kTextStyle18.copyWith(
                              color: AppColors.textLabelSelected),
                        ),
                        Text(cubit.state.orderData.status ?? '',
                            style: kTextStyle16),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 2,
                  color: AppColors.textLabelSelected,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text.rich(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  TextSpan(
                    text: "${context.tr('deliveryUserView.contactNumber')}:",
                    style:
                        kTextStyle16.copyWith(color: AppColors.primaryDriver),
                    children: [
                      TextSpan(
                        text: ' ${cubit.state.orderData.userPhone ?? ''}',
                        style: kTextStyle16.copyWith(
                          color: AppColors.textLabelUnSelected,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${context.tr('deliveryUserView.deliveryAddress')}:",
                  style: kTextStyle16.copyWith(color: AppColors.primaryDriver),
                ),
                Text(
                  ' ${cubit.state.orderData.address ?? ''}.',
                  style: kTextStyle16.copyWith(
                    color: AppColors.textLabelUnSelected,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 2,
                  color: AppColors.textLabelSelected,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "${context.tr('deliveryUserView.userMessage')}:",
                  style: kTextStyle16.copyWith(color: AppColors.primaryDriver),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.textLabelSelected, width: 2),
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    cubit.state.orderData.address ?? '',
                    style: kTextStyle16.copyWith(
                      color: AppColors.textLabelUnSelected,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                if (cubit.state.buttonState == RequestStateEnum.loading) ...{
                  const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.textLabelSelected,
                    ),
                  )
                } else ...{
                  if (cubit.state.orderData.status ==
                      OrderStateEnum.pending.key) ...{
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                            height: 45.h,
                            width: MediaQuery.of(context).size.width / 2,
                            backgroundColor: AppColors.isDark()
                                ? AppColors.iconPrimaryLight
                                : Colors.white,
                            borderColor: AppColors.iconDanger,
                            borderWidth: 1,
                            borderRadius: 8,
                            onPressed: () async {
                              bool? result = await context
                                  .read<OrdersDetailsCubit>()
                                  .cancelOrder();
                              if (result == true) {
                                Navigator.of(context).pop();
                              }
                            },
                            body: Text(
                                context.tr('deliveryUserView.declineOrder'),
                                style: kTextStyle16white.copyWith(
                                    color: AppColors.iconDanger)),
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
                            borderColor: AppColors.iconSuccess,
                            borderWidth: 1,
                            borderRadius: 8,
                            onPressed: () async {
                              bool? result = await context
                                  .read<OrdersDetailsCubit>()
                                  .acceptOrder();
                              // if (result == true) {
                              //   Navigator.of(context).pop();
                              // }
                            },
                            body: Text(
                                context.tr('deliveryUserView.acceptOrder'),
                                style: kTextStyle16white.copyWith(
                                    color: AppColors.iconSuccess)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  },
                  ButtonWidget(
                    height: 45.h,
                    width: MediaQuery.of(context).size.width,
                    backgroundColor: Colors.blue,
                    borderRadius: 8,
                    onPressed: () {
                      AppNavigator.push(BlocProvider(
                          create: (_) => ChatCubit(
                              orderData: cubit.state.orderData,
                              chatRepo: ChatRepoImpel()),
                          child: ChatScreen()));
                    },
                    body: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.tr('deliveryUserView.viewOrder'),
                            style: kTextStyle16white.copyWith(
                                color: AppColors.isDark()
                                    ? AppColors.black
                                    : AppColors.white)),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.chat,
                            color: AppColors.isDark()
                                ? AppColors.black
                                : AppColors.white),
                      ],
                    ),
                  ),
                }
              ],
            );
          }),
        ),
      ),
    );
  }
}
