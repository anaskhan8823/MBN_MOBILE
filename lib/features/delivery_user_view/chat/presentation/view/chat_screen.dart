import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/text_style.dart';
import '../../../home_delivery_user/data/enum/order_state_enum.dart';
import '../../../widget/auth_appbar_delivery_user_view.dart';
import '../../../widget/button_widget.dart';
import '../../../widget/message_widget.dart';
import '../controller/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controllerTextField = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatInitial>(
        builder: (context, currentIndex) {
      final cubit = context.read<ChatCubit>();
      return Scaffold(
        appBar: AuthAppbarDeliveryUserView(
          title: cubit.state.orderData.username ?? '',
          colorOfBackButton: AppColors.backButton,
          colorOfTitle: AppColors.primaryDriver,
          showLang: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.textLabelSelected, width: 3)),
                    child: Column(
                      children: [
                        if (cubit.state.orderData.status ==
                            OrderStateEnum.pending.key) ...{
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Row(
                              children: [
                                Text(
                                  "${context.tr('deliveryUserView.updateStatus')}:",
                                  style: kTextStyle14white.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.sp,
                                      color: AppColors.primaryDriver),
                                ),
                                const Spacer(),
                                ButtonWidget(
                                  height: 30.h,
                                  borderRadius: 16,
                                  onPressed: () async {
                                    bool? result = await context
                                        .read<ChatCubit>()
                                        .cancelOrder();
                                    if (result == true) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  backgroundColor: AppColors.isDark()
                                      ? AppColors.iconPrimaryLight
                                      : Colors.white,
                                  borderColor: AppColors.iconDanger,
                                  borderWidth: 1,
                                  body: Text(
                                      context.tr('deliveryUserView.reject'),
                                      style: kTextStyle16white.copyWith(
                                          color: AppColors.iconDanger,
                                          fontSize: 14.sp)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ButtonWidget(
                                  height: 30.h,
                                  borderRadius: 16,
                                  borderWidth: 1,
                                  onPressed: () async {
                                    bool? result = await context
                                        .read<ChatCubit>()
                                        .acceptOrder();
                                    if (result == true) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  backgroundColor: AppColors.textLabelSelected,
                                  borderColor: AppColors.textLabelSelected,
                                  body: Text(
                                      context.tr('deliveryUserView.delivered'),
                                      style: kTextStyle16white.copyWith(
                                          color: Colors.white,
                                          fontSize: 14.sp)),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: AppColors.textLabelSelected,
                            thickness: 3,
                          ),
                        },
                        SizedBox(
                          height: (MediaQuery.of(context).size.height / 3) *
                              (((cubit.state.orderData.status ==
                                      OrderStateEnum.pending.key))
                                  ? 1.9
                                  : 2.2),
                          child: ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemBuilder: (context, index) => MessageWidget(
                                  myMessage:
                                      cubit.state.messages[index].user?.id ==
                                          CachHelper.userId,
                                  data: cubit.state.messages[index]),
                              separatorBuilder: (context, item) =>
                                  const SizedBox(
                                    height: 10,
                                  ),
                              itemCount: cubit.state.messages.length),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.textLabelSelected, width: 2)),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.attach_file,
                          color: AppColors.textLabelSelected,
                          size: 30.sp,
                        )),
                    Expanded(
                        child: TextField(
                      controller: controllerTextField,
                      decoration: InputDecoration(
                        hintText:
                            context.tr('deliveryUserView.enterYourMessage'),
                        filled: true,

                        fillColor: Colors.transparent,
                        // Set background color to white
                        contentPadding: const EdgeInsets.all(16.0),
                        // Padding inside the TextField
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Colors
                                  .transparent), // Border color when enabled
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .transparent), // Border color when focused
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .transparent), // Border color when in error state
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .transparent), // Border color when focused and in error state
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Colors.transparent), // Default border color
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.textLabelSelected,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        context
                            .read<ChatCubit>()
                            .sendMessage(message: controllerTextField.text);
                        controllerTextField.clear();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      );
    });
  }
}
