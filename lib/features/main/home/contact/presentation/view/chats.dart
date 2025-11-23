import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

import '../../../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../../../widgets/custom_search_anchor.dart';
import '../../../../../widgets/custom_user_profile_image.dart';
import '../controller/manager_chat_cubit.dart';
import '../widget/item_of_contact_chat.dart';

class ChatsView extends StatelessWidget {
  ChatsView({super.key, this.colorOfAppBarTitle});
  final Color? colorOfAppBarTitle;
  final ScrollController paginationScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print('colorOfAppBarTitle:${colorOfAppBarTitle}');
    return Scaffold(
        appBar: AuthAppbar(
          showLang: false,
          title: "navHome.chat",
          hideBackButton: true,
          color: colorOfAppBarTitle,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
              child: CustomSearchAnchor(onChanged: (val) {
                context.read<ManagerChatCubit>().getContactFromSearch(val);
              }),
            ),
          ),
          heightAppBar: 100,
        ),
        body: BlocBuilder<ManagerChatCubit, ManagerChatState>(
            builder: (context, currentIndex) {
          final cubit = context.read<ManagerChatCubit>();
          return cubit.state.requestState == RequestStateEnum.loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: AppColors.textLabelSelected,
                )
              : SizedBox(
                  // height: MediaQuery.of(context).size.height / 2.3,
                  // fit: FlexFit.loose,
                  child: RefreshLoadmore(
                    onRefresh: () async {
                      await context
                          .read<ManagerChatCubit>()
                          .getHistoryOfContact(0);
                    },
                    onLoadmore: () async {
                      await Future.delayed(Duration(seconds: 1), () {
                        context
                            .read<ManagerChatCubit>()
                            .getHistoryOfContact(null);
                      });
                    },
                    isLastPage: false,
                    loadingWidget: CupertinoActivityIndicator(),
                    child: (cubit.state.tempHistoryOfChat.isEmpty)
                        ? Container(
                            height: 100.h,
                            alignment: Alignment.center,
                            child: Text(
                              context.tr('myProfile.empty_messages'),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.separated(
                            controller: paginationScrollController,
                            itemCount: cubit.state.tempHistoryOfChat.length,
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ItemOfContactChat(
                                data: cubit.state.tempHistoryOfChat[index],
                              );
                            },
                            separatorBuilder: (_, __) => Divider(
                                color: Colors.blueGrey.shade800, height: 1),
                          ),
                  ),
                );
        }));
  }
}
