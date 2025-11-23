import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../delivery_user_view/widget/auth_appbar_delivery_user_view.dart';
import '../../../../../delivery_user_view/widget/message_widget.dart';
import '../controller/manager_chat_cubit.dart';

class DetailsOfChat extends StatefulWidget {
  @override
  State<DetailsOfChat> createState() => _DetailsOfChatState();
}

class _DetailsOfChatState extends State<DetailsOfChat> {
  TextEditingController controllerTextField = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerChatCubit, ManagerChatState>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });

        return Scaffold(
          appBar: AuthAppbarDeliveryUserView(
            title: state.selectedContact?.contactName ?? '',
            colorOfBackButton: AppColors.backButton,
            colorOfTitle: AppColors.primaryDriver,
            showLang: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    itemCount: state.historyOfMessages.length,
                    itemBuilder: (context, index) {
                      final message = state.historyOfMessages[index];
                      return MessageWidget(
                        myMessage: message.user?.id == CachHelper.userId,
                        data: message,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                  ),
                ),
                const SizedBox(height: 25),
                _buildMessageInput(context),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textLabelSelected, width: 2),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.attach_file,
                color: AppColors.textLabelSelected, size: 30.sp),
          ),
          Expanded(
            child: TextField(
              controller: controllerTextField,
              decoration: InputDecoration(
                hintText: context.tr('deliveryUserView.enterYourMessage'),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.all(16.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              context.read<ManagerChatCubit>().sendMessage(
                    message: controllerTextField.text,
                  );
              controllerTextField.clear();
              _scrollToBottom();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.textLabelSelected,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
