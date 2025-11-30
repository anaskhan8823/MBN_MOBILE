import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helper/app_navigator.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../delivery_user_view/chat/data/model/contact_model.dart';
import '../../../../../widgets/custom_user_profile_image.dart';
import '../controller/manager_chat_cubit.dart';
import '../view/details_of_chat.dart';

class ItemOfContactChat extends StatelessWidget {
  final ContactFromListModel data;
  final Color? color;

  const ItemOfContactChat({super.key, required this.data, this.color});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        AppNavigator.push(BlocProvider.value(
          value: context.read<ManagerChatCubit>()..saveSelectedContact(data),
          child: DetailsOfChat(),
        ));
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CustomUserProfileImage(
        color: color ?? AppColors.primary,
        url: data.contactImage ?? '',
      ),
      title: Text(
        data.contactName ?? '',
        style: TextStyle(
            color: color ?? AppColors.primary,
            fontWeight: (data.unreadMessages ?? false)
                ? FontWeight.bold
                : FontWeight.normal,
            fontSize: 18),
      ),
      subtitle: Text(data.lastMessage ?? '',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: (data.unreadMessages ?? false)
                ? FontWeight.bold
                : FontWeight.normal,
          )),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            data.contactRole ?? '',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: (data.unreadMessages ?? false)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          // if (data.unreadMessages == true)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            child: const Text(
              '',
            ),
          )
        ],
      ),
    );
  }
}
