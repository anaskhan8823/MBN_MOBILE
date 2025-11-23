import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:flutter/material.dart';

import '../../core/style/app_colors.dart';
import '../../core/style/app_size.dart';
import 'custom_user_profile_image.dart';
class CardDriverItem extends StatelessWidget {
  const CardDriverItem({super.key, required this.name, required this.address});
final String name;
final String address;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.11,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color:AppColors.primaryDriver),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 55,
              height: 55,
              child:
              CustomUserProfileImage(color:AppColors.primaryDriver,) ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10, ),
              Text(
                name,
                style: kTextStyle16Orange.copyWith(color: AppColors.whiteAndBlackColor)
              ),
              const SizedBox(height: 5 ),
              Expanded(
                child: SizedBox(
                  width: AppSize.getWidth(170),
                  child: Text.rich(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    TextSpan(
                      text: "Address: ",
                      style:kTextStyle10Amber.copyWith(color: AppColors.primaryDriver),
                      children: [
                        TextSpan(
                          text: address,
                          style: TextStyle(color:AppColors.whiteAndBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const  SizedBox(height: 4, ),
               Text(
                "Pending Pickup",
                style:kTextStyle10Amber
              ),
              const SizedBox(height: 10, ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {},
                  child:  Text("View Order",
                      style: kTextStyle10Amber.copyWith(color: AppColors.blackAndWhiteColor)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
