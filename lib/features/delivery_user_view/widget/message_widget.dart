import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_size.dart';
import '../../../core/style/text_style.dart';
import '../chat/data/model/message_model.dart';

class MessageWidget extends StatelessWidget {
  final bool myMessage;
  final MessageModel data;

  const MessageWidget({super.key, required this.myMessage, required this.data});
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: myMessage ? 1 : -1, // Flip horizontally
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CachedNetworkImage(
              imageUrl: data.user?.avatar ?? data.user?.image ?? '',
              placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
              imageBuilder: (context, imageProvider) {
                return Transform.scale(
                    scaleX: myMessage ? 1 : -1, // Flip horizontally
                    child: Container(
                      width: AppSize.getWidth(45),
                      height: AppSize.getHeight(45),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: AppColors.textLabelSelected, width: 2),
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    ));
              },
              errorWidget: (context, url, error) {
                return Container(
                  width: AppSize.getWidth(45),
                  height: AppSize.getHeight(45),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.textLabelSelected, width: 2),
                    image: DecorationImage(
                        image: AssetImage(AppIcons.choosePhoto),
                        fit: BoxFit.fitWidth),
                  ),
                );
              }),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
                color: myMessage
                    ? AppColors.buttonPrimaryDark
                    : AppColors.textLabelSelected,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            child: Transform.scale(
                scaleX: myMessage ? 1 : -1, // Flip horizontally
                child: Text(
                  data.content ?? '',
                  style:
                      kTextStyle12whiteAndBlack.copyWith(color: Colors.white),
                  textAlign: TextAlign.end,
                )),
          )
        ],
      ),
    );
  }
}
