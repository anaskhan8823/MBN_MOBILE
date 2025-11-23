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
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                child: Image.network(
                  imageUrl,
                  height: MediaQuery.of(context).size.height * 0.19,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.products,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.19,
                      fit: BoxFit.cover,
                    );
                  },
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 0,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            storeName,
                            style: kTextStyle16Orange.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        RatingWidget(
                          startFirst: false,
                          rating: rating,
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppSize.getHeight(8),
                    ),
                    Row(
                      spacing: 4,
                      children: [
                        CustomSvg(
                          svg: AppIcons.phone,
                          color: AppColors.primary,
                          height: 18.h,
                        ),
                        Text(
                          phone,
                          style: TextStyle(
                            color: AppColors.labelInputColor,
                            fontSize: AppSize.getSize(13),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (isBlank(address) == false) ...{
                      SizedBox(
                        height: AppSize.getHeight(10),
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          CustomSvg(
                            svg: AppIcons.location,
                            color: AppColors.primary,
                            height: 18.h,
                          ),
                          Expanded(
                            child: Text(
                              address,
                              style: TextStyle(
                                color: AppColors.labelInputColor,
                                fontSize: AppSize.getSize(13),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    },
                    const SizedBox(
                      height: 15,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
