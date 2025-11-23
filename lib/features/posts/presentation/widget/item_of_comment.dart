import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../data/model/comments_model.dart';
import '../controller/posts_cubit.dart';
import 'alert_of_update_comment.dart';

enum MenuAction { edit, delete }

class ItemOfComment extends StatelessWidget {
  final CommentsModel data;

  const ItemOfComment({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CachedNetworkImage(
                imageUrl: data.user?.avatar ?? data.user?.image ?? '',
                placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: AppSize.getWidth(35),
                    height: AppSize.getHeight(35),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.buttonPrimaryLight),
                      image: DecorationImage(
                        image: imageProvider,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    width: AppSize.getWidth(35),
                    height: AppSize.getHeight(35),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.textLabelSelected),
                      image: DecorationImage(
                          image: AssetImage(AppIcons.choosePhoto),
                          fit: BoxFit.fitWidth),
                    ),
                  );
                }),
            SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text(
                  data.user?.name ?? '',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryLight,
                  ),
                ),
                Text(
                  data.content ?? '',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.textColor),
                ),
              ],
            )
          ],
        ),
        if (data.user?.id == CachHelper.userId) ...{
          PopupMenuButton<MenuAction>(
            onSelected: (MenuAction item) {
              if (item == MenuAction.edit) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                        value: context.read<PostsCubit>(),
                        child: AlertOfUpdateComment(
                          data: data,
                        ));
                  },
                );
              } else if (item == MenuAction.delete) {
                context
                    .read<PostsCubit>()
                    .deleteComment(commentId: data.id ?? 0);
              }
            },
            icon: const Icon(Icons.more_vert, color: AppColors.primaryLight),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
              PopupMenuItem<MenuAction>(
                  value: MenuAction.edit,
                  child: Text(context.tr('posts.edit'))),
              PopupMenuItem<MenuAction>(
                  value: MenuAction.delete,
                  child: Text(context.tr('posts.delete'))),
            ],
          ),
        }
      ],
    );
  }
}
