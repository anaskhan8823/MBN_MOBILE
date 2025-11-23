import 'package:dalil_2020_app/features/auth/data/enums/user_type_enum.dart';
import 'package:dalil_2020_app/features/main/home/nav_user_view.dart';
import 'package:dalil_2020_app/features/main/user_details/all_products/view.dart';
import 'package:flutter/material.dart';
import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/select_account_type/view.dart';
import 'package:dalil_2020_app/features/user/change_password/view.dart';
import 'package:dalil_2020_app/features/widgets/custom_user_profile_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/style/app_colors.dart';
import '../../core/utils.dart';
import '../auth/presentation/screens/login/view.dart';
import '../delivery_user_view/chat/data/repo/chat_repo_impel.dart';
import '../main/home/units/change_language.dart';
import '../main/home/units/item_for_my_profile.dart';
import '../main/home/units/switch_button.dart';
import '../posts/data/repo/posts_repo_impel.dart';
import '../posts/presentation/controller/posts_cubit.dart';
import '../posts/presentation/view/view_all_posts.dart';
import '../user/contact_us/view.dart';
import '../user/controllers/my_account_cubit.dart';
import '../user/delete_account/view.dart';
import '../user/edit_profile/view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    this.color,
  });
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final role = CachHelper.role;
    bool isAuth = CachHelper.isAuth;
    return BlocProvider(
      create: (_) => MyAccountCubit(),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: Drawer(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isAuth
                      ? Row(
                          children: [
                            CustomUserProfileImage(
                              color: color,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(CachHelper.userName!.split(' ').first,
                                    style: kTextStyle20White.copyWith(
                                        color: color ?? AppColors.primary)),
                                Text(CachHelper.role!.replaceAll("_", " "),
                                    style: kTextStyle20White.copyWith(
                                        color: AppColors.whiteAndBlackColor,
                                        fontSize: 12.sp)),
                              ],
                            )
                          ],
                        )
                      : Row(
                          spacing: AppSize.getWidth(10),
                          children: [
                            Expanded(
                              child: CustomButton(
                                title: context.tr("login.login"),
                                onTap: () =>
                                    AppNavigator.push(const SignInScreen()),
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                title: context.tr(
                                  "login.signUp",
                                ),
                                onTap: () => AppNavigator.push(
                                    const SelectAccountTypeScreen()),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 15),
                  Divider(
                      height: 1,
                      thickness: 2,
                      color: color ?? AppColors.primary),
                  const SizedBox(height: 15),
                  if (isAuth) ...[
                    Text('homeShopOwner.PersonalDetails'.tr(),
                        style: kTextStyle20White.copyWith(
                            color: color ?? AppColors.underlineColor)),
                    role != UserTypeEnum.user.key
                        ? Column(children: [
                            buildMenuItem(
                                iconColor: color ?? AppColors.primary,
                                context: context,
                                icon: AppIcons.home,
                                title: Utils.titleOfDrawerToNavigateToOwnHome,
                                onTap: Utils.navigateToOwnHome),
                            buildMenuItem(
                                iconColor: color ?? AppColors.primary,
                                context: context,
                                icon: AppIcons.home,
                                title: "drawer.defHome",
                                onTap: () =>
                                    AppNavigator.push(const NavUserView()))
                          ])
                        : buildMenuItem(
                            iconColor: color ?? AppColors.primary,
                            context: context,
                            icon: AppIcons.box,
                            title: "homeProductive.myProducts",
                            onTap: () {
                              AppNavigator.push(AllProductsForUserView(
                                storeName: "name",
                                numberPhone: "phone",
                              ));
                            },
                          ),
                    buildMenuItem(
                      iconColor: color ?? AppColors.primary,
                      context: context,
                      icon: AppSvg.languageSolid,
                      title: 'posts.Post2',
                      onTap: () {
                        AppNavigator.push(BlocProvider(
                            create: (_) =>
                                PostsCubit(postsRepo: PostsRepoImpel())
                                  ..getPosts(null, null, null)
                                  ..getCategory(),
                            child: ViewAllPosts()));
                      },
                    ),
                    buildMenuItem(
                      iconColor: color ?? AppColors.primary,
                      context: context,
                      icon: AppSvg.profileFill,
                      title: 'drawer.information',
                      onTap: () {
                        AppNavigator.push(
                            EditMyProfile(color: color ?? AppColors.primary));
                      },
                    ),
                    buildMenuItem(
                      iconColor: Colors.red,
                      textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      context: context,
                      icon: AppSvg.deleteRounded,
                      title: 'drawer.delAccount',
                      onTap: () {
                        AppNavigator.push(const DeleteAccount());
                      },
                      textColor: Colors.red,
                    ),
                    buildMenuItem(
                      iconColor: color ?? AppColors.primary,
                      context: context,
                      icon: AppSvg.key,
                      title: 'homeShopOwner.ChangePassword',
                      onTap: () {
                        AppNavigator.push(
                            ResetPassword(color: color ?? AppColors.primary));
                      },
                    ),
                    const SizedBox(height: 15),
                    Divider(
                        height: 1,
                        thickness: 2,
                        color: color ?? AppColors.primary),
                    const SizedBox(height: 15),
                  ],
                  Text('drawer.setting'.tr(),
                      style: kTextStyle20White.copyWith(
                          color: color ?? AppColors.underlineColor)),
                  BuildSwitchMenuItem(
                    color: color ?? AppColors.primary,
                    icon: AppSvg.profileFill,
                    title: 'homeShopOwner.night',
                  ),
                  buildMenuItem(
                    iconColor: color ?? AppColors.primary,
                    context: context,
                    icon: AppSvg.languageSolid,
                    title: 'homeShopOwner.Language',
                    onTap: () {
                      AppNavigator.push(const ChangeLanguage());
                    },
                  ),
                  buildMenuItem(
                    iconColor: color ?? AppColors.primary,
                    context: context,
                    icon: AppSvg.key,
                    title: 'homeShopOwner.ContactUs',
                    onTap: () {
                      AppNavigator.push(
                          ContactUs(color: color ?? AppColors.primary));
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
