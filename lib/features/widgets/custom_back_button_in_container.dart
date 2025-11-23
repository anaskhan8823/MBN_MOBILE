import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/helper/app_navigator.dart';
import '../../core/shared/widgets/custom_icon.dart';
import '../../core/style/app_size.dart';
class CustomBackButtonWithCircleContainer extends StatelessWidget {
  const CustomBackButtonWithCircleContainer({
    super.key,
    required this.color,
    required this.isEn,
  });

  final Color color;
  final bool isEn;

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          onTap: (){AppNavigator.pop();},
          child: Padding(
              padding:isEn?
              const EdgeInsets.only(left: 20.0):
              const EdgeInsets.only(right: 20.0),
              child:
              Container(
                decoration: BoxDecoration(
                  color:Theme.of(context).scaffoldBackgroundColor ,
                  shape: BoxShape.circle,
                  border: Border.all(color: color,),),
                child: CustomIcon(
                  padding: EdgeInsets.symmetric( horizontal: AppSize.getWidth(8)),
                  onTap: () => AppNavigator.pop(),
                  icon: isEn ? AppIcons.arrowLeft : AppIcons.arrowRight,
                  color: color,
                ),))
      );
  }
}
