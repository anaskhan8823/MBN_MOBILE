import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/widgets/rating_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiver/strings.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_colors.dart';

class StoreCardForUser extends StatelessWidget {
  final String imageUrl;
  final String storeName;
  final String rating;
  final String phone;
  final String address;
  const StoreCardForUser({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.storeName,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final doubleRating = double.tryParse(rating) ?? 0.0;
    final formattedRating = doubleRating.toStringAsFixed(1);
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                child: Image.network(
                  imageUrl,
                  height: MediaQuery.of(context).size.height * 0.16,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.products,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.16,
                      fit: BoxFit.cover,
                    );
                  },
                )),
          ),
          SizedBox(
            height: AppSize.getHeight(8),
          ),
          Expanded(
            flex: 0,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              storeName,
                              style: kTextStyle16Orange.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        RatingWidget(
                          startFirst: false,
                          rating: double.parse(formattedRating).toString(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.getHeight(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            spacing: 2,
                            children: [
                              CustomSvg(
                                svg: AppIcons.eyeOpen,
                                color: AppColors.primary,
                                height: 14.h,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "1",
                                style: TextStyle(
                                  color: AppColors.labelInputColor,
                                  fontSize: AppSize.getSize(12),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 2,
                            children: [
                              CustomSvg(
                                svg: AppIcons.box,
                                color: AppColors.primary,
                                height: 14.h,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                "1.1",
                                style: TextStyle(
                                  color: AppColors.labelInputColor,
                                  fontSize: AppSize.getSize(12),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppSize.getHeight(8),
                    ),
                    Row(
                      spacing: 2,
                      children: [
                        CustomSvg(
                          svg: AppIcons.phone,
                          color: AppColors.primary,
                          height: 14.h,
                        ),
                        Text(
                          phone,
                          style: TextStyle(
                            color: AppColors.labelInputColor,
                            fontSize: AppSize.getSize(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (isBlank(address) == false) ...{
                      SizedBox(
                        height: AppSize.getHeight(8),
                      ),
                      Row(
                        spacing: 2,
                        children: [
                          CustomSvg(
                            svg: AppIcons.location,
                            color: AppColors.primary,
                            height: 14.h,
                          ),
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              address,
                              style: TextStyle(
                                color: AppColors.labelInputColor,
                                fontSize: AppSize.getSize(12),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    },
                    SizedBox(
                      height: AppSize.getHeight(8),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
