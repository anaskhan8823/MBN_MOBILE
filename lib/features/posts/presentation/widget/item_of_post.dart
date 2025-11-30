import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_size.dart';
import '../../data/model/posts_model.dart';
import '../controller/posts_cubit.dart';
import '../view/post_details.dart';

class ItemOfPost extends StatelessWidget {
  final PostsModel data;

  const ItemOfPost({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppNavigator.push(BlocProvider.value(
            value: context.read<PostsCubit>()
              ..getCurrentPostDetails(postData: data, page: null),
            child: PostDetails()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryLight, width: 2),
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(08),
        child: Column(
          children: [
            Row(
              children: [
                CachedNetworkImage(
                    imageUrl: data.image ?? '',
                    placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: AppSize.getWidth(35),
                        height: AppSize.getHeight(35),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: AppColors.buttonPrimaryLight),
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
                          border:
                              Border.all(color: AppColors.textLabelSelected),
                          image: DecorationImage(
                              image: AssetImage(AppIcons.choosePhoto),
                              fit: BoxFit.fitWidth),
                        ),
                      );
                    }),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.user?.name ?? '',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.clock_fill,
                          color: AppColors.primaryLight,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          data.createdAt ?? '',
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryLight),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                data.content ?? '',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CachedNetworkImage(
                imageUrl: data.image ?? '',
                placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container();
                }),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<PostsCubit>()
                              .sendLikeCubit(postId: data.id ?? 0);
                        },
                        icon: SvgPicture.asset(
                          AppSvg.like,
                          color: (data.isLiked ?? false)
                              ? AppColors.primaryLight
                              : AppColors.textColor,
                          width: 20.w,
                        )),
                    Text(
                      data.likesCount.toString(),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Transform.flip(
                        flipX: true,
                        child: const Icon(Icons.message,
                            color: AppColors.primaryLight)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      data.commentsCount.toString(),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
