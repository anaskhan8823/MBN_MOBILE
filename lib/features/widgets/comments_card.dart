import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rate/rate.dart';
import '../../core/app_assets.dart';
import '../../core/style/app_colors.dart';
class CommentCard extends StatelessWidget {
  const CommentCard({super.key, this.color, required this.name, required this.image, required this.comment, required this.rating});
final Color?color;
final String name;
final String image;
final String comment;
final double rating;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.greyAndWhiteWithShadowColor,
          borderRadius: const BorderRadius.all(
              Radius.circular(12)
          ),
          border: Border.all(color:
          color!=null?AppColors.borderContainerColor:AppColors.borderContainerColorProductive)
      ),
      child: Row(
        spacing: 5,
        children: [
          const SizedBox(),
        CircleAvatar(
        backgroundColor: AppColors.containerBack,
    radius: 20,
    backgroundImage:image.isNotEmpty? NetworkImage(image):AssetImage(AppIcons.choosePhoto),
        ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // spacing: AppSize.getWidth(80),
                  children: [
                    Text(name,
                        style: TextStyle(
                            color:color?? AppColors.primary,
                            fontSize: AppSize.font(14),
                            fontWeight: FontWeight.bold)),
                      Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Rate(
                        iconSize: 18,
                        color:color??AppColors.primary,
                        allowHalf: true,
                        initialValue: rating,
                        onChange: (value){},
                      ),
                    )
                  ],
                ),
                Text(comment,
                    style: TextStyle(
                      color: AppColors.whiteAndBlackColor,
                      fontSize: AppSize.font(14),
            
                    ))
              ],
            ),
          ),

        ],
      ),

    );
  }
}
