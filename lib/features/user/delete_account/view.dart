import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_field_text.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/app_loading.dart';
import '../../../core/helper/dialogs.dart';
import '../../../core/style/app_size.dart';
import '../controllers/my_account_cubit.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyAccountCubit(),
      child: Scaffold(
        body: BlocBuilder<MyAccountCubit, MyAccountState>(
            builder: (context, state) {
          final cubit = context.read<MyAccountCubit>();
          if (state is MyAccountLoading) {
            return const AppLoading();
          }
          return Form(
            key: cubit.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  AuthAppbar(
                    showLang: false,
                    title: "myProfile.deleteAccount".tr(),
                  ),
                  SizedBox(height: AppSize.getHeight(25)),
                  Text(
                    textAlign: TextAlign.center,
                    "myProfile.enterPassword".tr(),
                    style: kTextStyle16white.copyWith(fontSize: 11),
                  ),
                  SizedBox(height: AppSize.getHeight(35)),
                  CustomFieldText(
                      isRequired: true,
                      labelText: 'sign_up.password'.tr(),
                      controller: cubit.passwordController,
                      errorText: ''),
                  SizedBox(height: AppSize.getHeight(70)),
                  CustomButton(
                      title: "myProfile.confirm".tr(),
                      onTap: () {
                        if (!cubit.formKey.currentState!.validate()) {
                          return;
                        } else {
                          displayDeleteSheet(context, () {
                            cubit.deleteAccount();
                          });
                        }
                      })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
