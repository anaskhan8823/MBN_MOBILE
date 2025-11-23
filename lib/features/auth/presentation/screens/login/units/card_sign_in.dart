import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CardSignInMethods extends StatelessWidget {
  const CardSignInMethods({
    super.key,   this.method, this.image,
  });
final String ?method ;
final Widget? image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        padding: AppSize.padding(horizontal: 13,vertical: 8),
        decoration: BoxDecoration(
           border: Border.all(
             color: AppColors.borderContainerColor,
             width: 3
           ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child:image??
        SvgPicture.asset(
          method!,
          fit: BoxFit.scaleDown,
        )
      ),
    );
  }
}
