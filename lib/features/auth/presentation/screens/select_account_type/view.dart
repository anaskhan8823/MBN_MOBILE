import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/auth/data/enums/user_type_enum.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:dalil_2020_app/features/auth/presentation/screens/select_account_type/units/select_user_type_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helper/app_navigator.dart';
import '../../../../../core/shared/widgets/app_logo_with_name.dart';
import '../../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../../core/shared/widgets/container_with_background_image.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../../core/style/text_style.dart';
import '../../../../main/home/nav_user_view.dart';
import '../../../data/repo/auth_repo_impel.dart';
import '../../widgets/auth_or_separator.dart';
import '../../widgets/custom_floating_button.dart';
import '../login/view.dart';
import '../register/view.dart';
part 'units/already_have_account.dart';
part 'package:dalil_2020_app/features/auth/presentation/screens/select_account_type/units/continue_without_login.dart';

class SelectAccountTypeScreen extends StatelessWidget {
  const SelectAccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocProvider(
          create: (_) => AuthCubit(AthRepoImpel()),
          child: BlocBuilder<AuthCubit, AuthStates>(
            builder: (context, state) {
              final cubit = AuthCubit.get(context);
              return ContainerWithBackgroundImage(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const AuthAppbar(),
                      const AppLogoWithName(),
                      SizedBox(height: AppSize.getHeight(40)),
                      Text(context.tr("choose_account.your_new_mind"),
                          style: kTextStyle20White),
                      Text(context.tr("choose_account.please_choose"),
                          textAlign: TextAlign.center,
                          style: kTextStyle14white.copyWith(
                              color: AppColors.labelInputColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: AppSize.getHeight(24)),
                      SelectUserTypeCard(
                          title: "choose_account.shop_owner",
                          onTap: () {
                            cubit.changeUserType(UserTypeEnum.shopOwner.key);
                            AppNavigator.push(const SignUpScreen(
                              userTypeEnum: UserTypeEnum.shopOwner,
                            ));
                          }),
                      SizedBox(height: AppSize.getHeight(16)),
                      SelectUserTypeCard(
                          title: "choose_account.representative",
                          onTap: () {
                            cubit.changeUserType(
                                UserTypeEnum.representative.key);
                            AppNavigator.push(
                              const SignUpScreen(
                                userTypeEnum: UserTypeEnum.representative,
                              ),
                            );
                          }),
                      SizedBox(height: AppSize.getHeight(16)),
                      SelectUserTypeCard(
                          title: "choose_account.personal_user",
                          onTap: () {
                            cubit.changeUserType(UserTypeEnum.user.key);
                            AppNavigator.push(
                              const SignUpScreen(
                                userTypeEnum: UserTypeEnum.user,
                              ),
                            );
                          }),
                      SizedBox(height: AppSize.getHeight(16)),
                      SelectUserTypeCard(
                          title: "choose_account.productive_families",
                          onTap: () {
                            cubit.changeUserType(
                                UserTypeEnum.productiveFamilies.key);
                            AppNavigator.push(
                              const SignUpScreen(
                                userTypeEnum: UserTypeEnum.productiveFamilies,
                              ),
                            );
                          }),
                      SizedBox(height: AppSize.getHeight(16)),
                      const AuthOrSeparator(),
                      SizedBox(height: AppSize.getHeight(24)),
                      const AlreadyHaveAccount(),
                      SizedBox(height: AppSize.getHeight(16)),
                      const ContinueWithoutLogin(),
                      SizedBox(height: AppSize.getHeight(32)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: CustomFloatingButton());
  }
}
