import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/features/controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_size.dart';

class UploadPhotoCard extends StatelessWidget {
  const UploadPhotoCard({
    super.key,
    this.color,
    this.url,
  });
  final Color? color;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPhotoCubit, UploadPhotoState>(
      builder: (context, state) {
        final cubit = context.read<UploadPhotoCubit>();
        return GestureDetector(
          onTap: () {
            cubit.changeProfile();
            cubit.profileImage = null;
          },
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              cubit.profileImage == null
                  ? CircleAvatar(
                      backgroundColor: AppColors.containerBack,
                      radius: 50,
                      backgroundImage:
                          NetworkImage(url ?? CachHelper.image ?? ''),
                      onBackgroundImageError: (_, __) {},
                      child: (url == null && CachHelper.image == null)
                          ? Image.asset(
                              AppIcons.choosePhoto,
                              fit: BoxFit.scaleDown,
                              height: 70.h,
                              width: 70.h,
                            )
                          : null,
                    )
                  : CircleAvatar(
                      radius: 50,
                      child: Container(
                          decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              FileImage(cubit.profileImage!) as ImageProvider,
                        ),
                      )),
                    ),
              Container(
                padding: AppSize.padding(all: 5),
                decoration: BoxDecoration(
                    color: color ?? AppColors.primary, shape: BoxShape.circle),
                child: CustomSvg(
                  svg: AppIcons.edit,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
