import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_assets.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../core/shared/widgets/custom_icon.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../auth/presentation/screens/register/units/upload_photo_card.dart';
import '../../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import '../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../main/add_product/units/upload_product_image.dart';
import '../../../widgets/custom_drop_button.dart';
import '../../data/model/posts_model.dart';
import '../controller/posts_cubit.dart';

class CreatePosts extends StatelessWidget {
  final TextEditingController englishDisc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isEn = context.locale.languageCode == 'en';

    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      final uploadCubit = context.read<UploadPhotoCubit>();

      return Scaffold(
        appBar: AppBar(
          leading: CustomIcon(
            padding: isEn
                ? const EdgeInsets.only(left: 16)
                : const EdgeInsets.only(right: 5),
            onTap: () => AppNavigator.pop(),
            icon: isEn ? AppIcons.arrowLeft : AppIcons.arrowRight,
            width: AppSize.getWidth(24),
            height: AppSize.getHeight(24),
            color: AppColors.iconColor,
          ),
          title: Text(
            context.tr("posts.CreatePost"),
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                fontFamily: (CachHelper.lang ?? 'ar') == 'ar'
                    ? 'STV'
                    : GoogleFonts.poppins().fontFamily ?? 'Poppins',
                color: AppColors.primary),
          ),
          actions: [
            InkWell(
              onTap: () {
                context
                    .read<PostsCubit>()
                    .createPost(uploadCubit.profileImage, englishDisc.text);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  context.tr("posts.Post"),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: (CachHelper.lang ?? 'ar') == 'ar'
                          ? 'STV'
                          : GoogleFonts.poppins().fontFamily ?? 'Poppins',
                      color: AppColors.primary),
                ),
              ),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: state.requestStateOfAddPost == RequestStateEnum.loading
                ? Center(
                    child: CupertinoActivityIndicator(
                      color: AppColors.primaryLight,
                    ),
                  )
                : ListView(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.image,
                            color: AppColors.buttonPrimaryLight,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context.tr('posts.uploadYourPhotos'),
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonPrimaryLight),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: UploadPhotoCard(
                          url: '',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppSvg.description,
                            color: AppColors.buttonPrimaryLight,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            context.tr('posts.YourDescription'),
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.buttonPrimaryLight),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => AppValidators.required(value),
                        controller: englishDisc,
                        style: TextStyle(color: AppColors.whiteAndBlackColor),
                        decoration: InputDecoration(
                          label: Text(
                            'posts.YourDescription2'.tr(),
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.labelInputColor),
                          ),
                        ),
                        maxLines: 5,
                        maxLength: 500,
                        minLines: 5,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomDropButton(
                        dropButton: DropdownButton<CategoryPostModel>(
                          style: const TextStyle(color: Colors.white),
                          // isExpanded: true,
                          icon: const SizedBox(),
                          underline: const SizedBox(),
                          value: state.selectedCategoryId,
                          hint: Row(
                            spacing: 5,
                            children: [
                              CustomSvg(
                                svg: AppSvg.category,
                                color: AppColors.iconColor,
                              ),
                              Text('addProduct.allC'.tr(),
                                  style: TextStyle(
                                      color: AppColors.whiteAndBlackColor)),
                            ],
                          ),
                          items: state.listOfCategory.map((category) {
                            String? name = context.locale == const Locale('ar')
                                ? category.name?.ar
                                : category.name?.en;
                            return DropdownMenuItem<CategoryPostModel>(
                                value: category,
                                child: Text(name ?? 'No Name',
                                    style: kTextStyle16white.copyWith(
                                        color: AppColors.dropButtonTextColor)));
                          }).toList(),
                          onChanged: (value) {
                            context
                                .read<PostsCubit>()
                                .submitSelectedCategory(value);
                          },
                        ),
                      ),
                    ],
                  )),
      );
    });
  }
}
