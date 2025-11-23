import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
class EditProductImage extends StatelessWidget {
  const EditProductImage({super.key, this.color, required this.initialImages});
  final List<File> initialImages;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UploadPhotoCubit>();
    if (cubit.imagesListsEdit.isEmpty) {
      cubit.setInitialImages(initialImages);
    }
    return BlocBuilder<UploadPhotoCubit, UploadPhotoState>(
      builder: (context, state) {
        final images = cubit.imagesListsEdit;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.getHeight(110),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: cubit.imagesListsEdit.length * 110.w,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.imagesListsEdit.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () async {
                                cubit.pickImage(index);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: AppSize.getWidth(110),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: color ?? AppColors.primary,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(
                                          AppSize.getSize(16)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(images[index]),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () => cubit.removeImages(index),
                                      child: const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.red,
                                        child: Icon(Icons.close,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (images.length < 5) ...[
                      GestureDetector(
                        onTap: () => cubit.pickImagesEdit(),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: color ?? AppColors.primary, width: 2),
                            borderRadius:
                                BorderRadius.circular(AppSize.getSize(16)),
                          ),
                          child: Icon(Icons.add,
                              color: color ?? AppColors.primary, size: 40),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                children:[
                  Text(
                  "${images.length}/5",
                  style: TextStyle(color: Colors.grey, fontSize: AppSize.font(13)),
                ),
                  Text(
                  "change.upload".tr(),
                  style: TextStyle(color: Colors.grey, fontSize: AppSize.font(13)),
                ),

                ]
              ),
            ),
          ],
        );
      },
    );
  }
}
