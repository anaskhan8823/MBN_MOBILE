import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constans.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';
import '../../add_product/view.dart';

class AddProductService extends StatelessWidget {
  const AddProductService({
    super.key,
    required this.service,
    required this.color,
    required this.svgIcon,
  });
  final String service;
  final Color color;
  final String svgIcon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(AddProduct(enterScreen: kUser, storeId: null));
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: color,
            width: 3,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 3,
          children: [
            SvgPicture.asset(svgIcon),
            Text(service.tr(),
                style: kTextStyle10.copyWith(
                    color: color, fontSize: AppSize.getSize(14)))
          ],
        ),
      ),
    );
  }
}
