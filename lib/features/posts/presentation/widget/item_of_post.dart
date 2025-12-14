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
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryLight, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Row
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: (data.user?.image ?? '').isNotEmpty
                      ? data.user!.image!
                      : AppIcons.choosePhoto,
                  placeholder: (context, url) =>
                      const Center(child: CupertinoActivityIndicator()),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: AppSize.getWidth(35),
                      height: AppSize.getHeight(35),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.buttonPrimaryLight),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
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
                            fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
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
                      children: [
                        const Icon(
                          CupertinoIcons.clock_fill,
                          color: AppColors.primaryLight,
                          size: 12,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          data.createdAt ?? '',
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryLight),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Post content
            Text(
              data.content ?? '',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10),

            // Post images
            buildPostImages(context),

            const SizedBox(height: 10),

            // Like & Comment Row
            Row(
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
                      ),
                    ),
                    Text(
                      data.likesCount.toString(),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Row(
                  children: [
                    Transform.flip(
                      flipX: true,
                      child: const Icon(Icons.message,
                          color: AppColors.primaryLight),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      data.commentsCount.toString(),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostImages(BuildContext context) {
    if (data.image == null || data.image!.isEmpty) {
      return const SizedBox.shrink();
    } else if (data.image!.length == 1) {
      // Single image
      return CachedNetworkImage(
        imageUrl: data.image![0],
        placeholder: (context, url) =>
            const Center(child: CupertinoActivityIndicator()),
        imageBuilder: (context, imageProvider) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
        errorWidget: (context, url, error) => Container(),
      );
    } else {
      // Multiple images - GridView
      final int imageCount = data.image!.length > 4 ? 4 : data.image!.length;
      final int rowCount = (imageCount / 2).ceil();

      return SizedBox(
        height:
            rowCount * 150.0 + ((rowCount - 1) * 4), // 150 per row + spacing
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: imageCount,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: data.image![index],
                  placeholder: (context, url) =>
                      const Center(child: CupertinoActivityIndicator()),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Container(),
                ),
                if (index == 3 && data.image!.length > 4)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+${data.image!.length - 4}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            );
          },
        ),
      );
    }
  }
}
