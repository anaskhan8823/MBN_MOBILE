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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/app_colors.dart';
import '../../../auth/presentation/screens/login/view.dart';
import '../../../user/contact_us/view.dart';
import '../../../user/controllers/my_account_cubit.dart';
import '../../../user/delete_account/view.dart';
import '../../../user/edit_profile/view.dart';
import '../units/change_language.dart';
import '../units/item_for_my_profile.dart';
import '../units/switch_button.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    bool isAuth = CachHelper.isAuth;
    return BlocProvider(
      create: (_) => MyAccountCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 55,
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
                              Text('homeShopOwner.GoodDay'.tr(),
                                  style: kTextStyle20White.copyWith(
                                      color: AppColors.whiteAndBlackColor)),
                              Text(CachHelper.userName ?? 'user',
                                  style: kTextStyle20White.copyWith(
                                      color: color ?? AppColors.primary))
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
                const SizedBox(height: 24),
                Divider(
                    height: 1, thickness: 2, color: color ?? AppColors.primary),
                const SizedBox(height: 24),
                if (isAuth) ...[
                  Text('homeShopOwner.PersonalDetails'.tr(),
                      style: kTextStyle20White.copyWith(
                          color: color ?? AppColors.underlineColor)),
                  const SizedBox(height: 8),
                  buildMenuItem(
                    iconColor: color ?? AppColors.primary,
                    context: context,
                    icon: AppSvg.profileFill,
                    title: 'homeShopOwner.edit',
                    onTap: () {
                      AppNavigator.push(
                          EditMyProfile(color: color ?? AppColors.primary));
                    },
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
                buildMenuItem(
                  iconColor: color ?? AppColors.primary,
                  context: context,
                  icon: AppSvg.languageSolid,
                  title: 'homeShopOwner.Language',
                  onTap: () {
                    AppNavigator.push(const ChangeLanguage());
                  },
                ),
                BuildSwitchMenuItem(
                  color: color ?? AppColors.primary,
                  icon: AppSvg.profileFill,
                  title: 'homeShopOwner.night',
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
                if (isAuth) ...[
                  const SizedBox(height: 24),
                  Divider(
                      height: 1,
                      thickness: 2,
                      color: color ?? AppColors.primary),
                  const SizedBox(height: 16),
                  Text('homeShopOwner.AccountManagement'.tr(),
                      style: kTextStyle20White.copyWith(
                          color: color ?? AppColors.underlineColor)),
                  buildMenuItem(
                    iconColor: Colors.red,
                    textStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                    context: context,
                    icon: AppSvg.deleteRounded,
                    title: 'homeShopOwner.DeleteMyAccount',
                    onTap: () {
                      AppNavigator.push(const DeleteAccount());
                    },
                    textColor: Colors.red,
                  ),
                  buildMenuItem(
                    iconColor: color ?? AppColors.primary,
                    context: context,
                    icon: AppSvg.signOut,
                    title: 'homeShopOwner.SignOut',
                    onTap: () async {
                      await CachHelper.removeExceptThemeAndLang();
                      AppNavigator.remove(const SignInScreen());
                    },
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
