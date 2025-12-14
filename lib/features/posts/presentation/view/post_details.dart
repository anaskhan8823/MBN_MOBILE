import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../core/shared/widgets/custom_icon.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../controller/posts_cubit.dart';
import '../widget/item_of_comment.dart';

class PostDetails extends StatefulWidget {
  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final ScrollController paginationScrollController = ScrollController();
  TextEditingController controllerTextField = TextEditingController();
  bool failedToGetImage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
        final cubit = context.read<PostsCubit>();
        return Column(
          children: [
            const AuthAppbar(
              hideBackButton: false,
              showLang: false,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height - 110.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildPostImageSlider(),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor),
                              text: "posts.asked".tr(),
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryLight),
                                    text: state.currentPost?.createdAt ?? ''),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor),
                              text: "posts.answers".tr(),
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryLight),
                                    text:
                                        (state.currentPost?.commentsCount ?? '')
                                            .toString()),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CachedNetworkImage(
                            imageUrl: state.currentPost?.user?.image ?? '',
                            placeholder: (context, url) => const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: AppSize.getWidth(35),
                                height: AppSize.getHeight(35),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: AppColors.buttonPrimaryLight,
                                      width: 2),
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
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: AppColors.buttonPrimaryLight,
                                      width: 2),
                                  image: DecorationImage(
                                      image: AssetImage(AppIcons.choosePhoto),
                                      fit: BoxFit.fitWidth),
                                ),
                              );
                            }),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "posts.askedBy".tr(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          state.currentPost?.user?.name ?? '',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: AppColors.primaryLight,
                      thickness: 2,
                    ),
                    Container(
                      width: double.infinity, // full width
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize
                            .min, // allows column to shrink to fit content
                        children: [
                          Text(
                            "posts.postDetails".tr(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.currentPost?.content ?? '',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          // Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     IconButton(
                          //       onPressed: () {
                          //         context.read<PostsCubit>().sendLikeCubit(
                          //             postId: state.currentPost?.id ?? 0);
                          //       },
                          //       icon: SvgPicture.asset(
                          //         AppSvg.like,
                          //         color: (state.currentPost?.isLiked ?? false)
                          //             ? AppColors.primaryLight
                          //             : AppColors.textColor,
                          //         width: 18.w,
                          //       ),
                          //     ),
                          //     Text(
                          //       (state.currentPost?.likesCount ?? 0).toString(),
                          //       style: TextStyle(
                          //         fontSize: 12.sp,
                          //         fontWeight: FontWeight.w700,
                          //         color: AppColors.textColor,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildMessageInput(context),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("posts.otherComments".tr(),
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor)),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height -
                                  ((200.h + 55) +
                                      ((cubit.state.currentPost?.image ==
                                                  null ||
                                              failedToGetImage == true)
                                          ? 260.h
                                          : 400.h)), // Adjust as needed

                              child: RefreshLoadmore(
                                padding: EdgeInsets.zero,
                                onRefresh: () async {
                                  await context
                                      .read<PostsCubit>()
                                      .getCommentsPost(0);
                                },
                                onLoadmore: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 1), () {
                                    context
                                        .read<PostsCubit>()
                                        .getCommentsPost(null);
                                  });
                                },
                                isLastPage: false,
                                loadingWidget:
                                    const CupertinoActivityIndicator(),
                                child: cubit.state.listOfPosts.isEmpty
                                    ? Container(
                                        height: 100.h,
                                        alignment: Alignment.center,
                                        child: Text(
                                          context.tr('posts.emptyState'),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                ((200.h + 55) +
                                                    ((cubit.state.currentPost
                                                                    ?.image ==
                                                                null ||
                                                            failedToGetImage ==
                                                                true)
                                                        ? 260.h
                                                        : 400.h)),
                                        child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          controller:
                                              paginationScrollController,
                                          itemCount:
                                              cubit.state.listOfComments.length,
                                          shrinkWrap: true,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            // print(
                                            //     "object${cubit.state.listOfComments.length}");
                                            return BlocProvider.value(
                                                value:
                                                    context.read<PostsCubit>(),
                                                child: ItemOfComment(
                                                  data: cubit.state
                                                      .listOfComments[index],
                                                ));
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const SizedBox(height: 16);
                                          },
                                        ),
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildPostImageSlider() {
    final images = context.read<PostsCubit>().state.currentPost?.image;
    if (images == null || images.isEmpty || failedToGetImage) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        return CachedNetworkImage(
          imageUrl: images[index],
          placeholder: (context, url) =>
              const Center(child: CupertinoActivityIndicator()),
          imageBuilder: (context, imageProvider) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            );
          },
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Icon(Icons.error),
          ),
        );
      },
      options: CarouselOptions(
        height: 250,
        viewportFraction: 0.9,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.isDark()
            ? AppColors.buttonPrimaryLight.withOpacity(.2)
            : Colors.white,
        border: Border.all(color: AppColors.buttonPrimaryLight, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              scrollPadding: EdgeInsets.zero,
              controller: controllerTextField,
              decoration: InputDecoration(
                hintText: context.tr('posts.enterYouComment'),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              context.read<PostsCubit>().sendComment(
                    message: controllerTextField.text,
                  );
              controllerTextField.clear();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.buttonPrimaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    context.tr("posts.Send"),
                    style: TextStyle(fontSize: 13.sp, color: Colors.black),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.send,
                    color: Colors.black,
                    size: 15.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<PostsCubit>().cleanCurrentPost();
  }

  @override
  void dispose() {
    super.dispose();
    context.read<PostsCubit>().cleanCurrentPost();
  }
}
