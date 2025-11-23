import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/validators/app_validators.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/shared/widgets/auth_appbar.dart';
import '../../../core/style/app_size.dart';
import '../../../core/style/text_style.dart';
import '../../widgets/helper_label_text_for_field.dart';
import '../controllers/my_account_cubit.dart';
class ContactUs extends StatelessWidget {
  const ContactUs({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
            create: (_) => MyAccountCubit(),
        child: Scaffold(
            extendBody: true,
            appBar: AuthAppbar(
              title: "homeShopOwner.ContactUs",
              showLang: false,
              color: color,
            ),
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(child:
                BlocBuilder<MyAccountCubit, MyAccountState>(
                    builder: (context, state) {
              final cubit = context.read<MyAccountCubit>();
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AppSize.getHeight(8),
                          ),
                          Text("myProfile.issue".tr(),textAlign: TextAlign.center,
                              style:kTextStyle14white.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w500)
                          ),
                          SizedBox(
                            height: AppSize.getHeight(20),
                          ),

                          const HelperLabelTextForFiled(
                            label: 'myProfile.subject',
                          ),
                          SizedBox(
                            height: AppSize.getHeight(4),
                          ),
                          TextFormField(
                            validator: (value) => AppValidators.required(value),
                            controller:  cubit.subjectController,
                            style:  TextStyle(color: AppColors.whiteAndBlackColor),
                          ),
                          SizedBox(
                            height: AppSize.getHeight(15),
                          ),
                              const HelperLabelTextForFiled(
                                label: 'myProfile.msg',
                              ),
                          SizedBox(
                            height: AppSize.getHeight(4),
                          ),
                          TextFormField(
                            validator: (value) => AppValidators.required(value),
                            minLines: 5,maxLines: 500,
                            controller:  cubit.messageController,
                            style:  TextStyle(color: AppColors.whiteAndBlackColor),
                          ),
                          SizedBox(
                            height: AppSize.getHeight(35),
                          ),

                          CustomButton(
                                bgColor: color ?? AppColors.primary,
                                title: 'myProfile.send'.tr(),
                                onTap: () {
                                  cubit.contactUs();
                                },
                                loading: state is MyAccountLoading,
                              ),
                              SizedBox(
                                height: AppSize.getHeight(20),
                              ),
                            ],
                          ),
                  ),

              );
            }))));
  }
}
