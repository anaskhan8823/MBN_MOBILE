import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/widgets/rating_.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_colors.dart';
import 'custom_eye.dart';

class StoreCard extends StatelessWidget {
  final String imageUrl;
  final String storeName;
  final num views;
  final String rating;
  final num products;
  final bool homeOfUser;
  const StoreCard({
    super.key,
    required this.imageUrl,
    required this.storeName,
    required this.views,
    required this.rating,
    required this.products,
    this.homeOfUser = false,
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
          ClipRRect(
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
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (homeOfUser) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "navHome.shops".tr(),
                        style: kTextStyle16Orange.copyWith(fontSize: 12),
                      ),
                      RatingWidget(
                        startFirst: false,
                        rating: rating,
                      )
                    ],
                  ),
                ],
                SizedBox(
                  height: AppSize.getHeight(8),
                ),
                Text(
                  storeName,
                  style: TextStyle(
                    color: AppColors.labelInputColor,
                    fontSize: AppSize.getSize(14),
                    fontWeight: FontWeight.w600,
                    // only one line
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                if (!homeOfUser) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Views
                      CustomEyeView(views: views),
                      if (double.parse(rating) > 0)
                        RatingWidget(startFirst: false, rating: rating)
                      else
                        Text('navHome.noRatingsYet'.tr(),
                            style: kTextStyle13.copyWith(fontSize: 8)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    spacing: 3,
                    children: [
                      CustomSvg(svg: AppIcons.box),
                      Text(' $products', style: kTextStyle13),
                      Text('navHome.product'.tr(), style: kTextStyle13)
                    ],
                  ),
                ],
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
