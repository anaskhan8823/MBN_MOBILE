import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/utils.dart';
import '../../../auth/presentation/widgets/custom_floating_button.dart';
import '../../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import '../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../main/home/units/searchBar.dart';
import '../../../main/home/widget/main_nav_user_view.dart';
import '../../../widgets/custom_drawer.dart';
import '../../data/repo/posts_repo_impel.dart';
import '../controller/posts_cubit.dart';
import '../widget/item_of_post.dart';
import 'create_post.dart';

class ViewAllPosts extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController paginationScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      floatingActionButton: CustomFloatingButton(),
      bottomNavigationBar: Utils.getBottomNavigationBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.getWidth(25),
              vertical: AppSize.getHeight(10),
            ),
            child: buildSearchBar(() => _scaffoldKey.currentState?.openDrawer(),
                onChanged: (val) {
              context.read<PostsCubit>().getPosts(0, val, null);
            }),
          ),
          BlocBuilder<PostsCubit, PostsState>(builder: (context, currentIndex) {
            final cubit = context.read<PostsCubit>();
            final isEn = context.locale.languageCode == 'en';
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 60.h,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              color: AppColors.primaryDark.withOpacity(.2),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                // controller: paginationScrollController,
                scrollDirection: Axis.horizontal,
                itemCount: cubit.state.listOfCategory.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      await context.read<PostsCubit>().getPosts(
                          0, null, cubit.state.listOfCategory[index].id);
                    },
                    child: Text(
                      isEn
                          ? (cubit.state.listOfCategory[index].name?.en ?? '')
                          : (cubit.state.listOfCategory[index].name?.ar ?? ''),
                      style: TextStyle(color: AppColors.primaryLight),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
              ),
            );
          }),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (context.locale.languageCode == 'en') ...{const SizedBox()},
              InkWell(
                onTap: () {
                  AppNavigator.push(MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => UploadPhotoCubit(),
                        ),
                      ],
                      child: BlocProvider.value(
                          value: context.read<PostsCubit>(),
                          child: CreatePosts())));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: AppColors.primaryLight, width: 2)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: AppColors.primaryLight,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        context.tr("posts.Add_new_post"),
                        style: TextStyle(
                            color: AppColors.iconPrimaryOfTheme2,
                            fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ),
              if (context.locale.languageCode != 'en') ...{const SizedBox()},
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<PostsCubit, PostsState>(builder: (context, currentIndex) {
            final cubit = context.read<PostsCubit>();
            return cubit.state.requestState == RequestStateEnum.loading
                ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.textLabelSelected,
                    ),
                  )
                : Expanded(
                    child: RefreshLoadmore(
                      padding: EdgeInsets.zero,
                      onRefresh: () async {
                        await context
                            .read<PostsCubit>()
                            .getPosts(0, null, null);
                      },
                      onLoadmore: () async {
                        await Future.delayed(const Duration(seconds: 1), () {
                          context.read<PostsCubit>().getPosts(null, null, null);
                        });
                      },
                      isLastPage: false,
                      loadingWidget: const CupertinoActivityIndicator(),
                      child: cubit.state.listOfPosts.isEmpty
                          ? Container(
                              height: 100.h,
                              alignment: Alignment.center,
                              child: Text(
                                context.tr('posts.emptyState'),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              controller: paginationScrollController,
                              itemCount: cubit.state.listOfPosts.length,
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return ItemOfPost(
                                  data: cubit.state.listOfPosts[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 16,
                                );
                              },
                            ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
