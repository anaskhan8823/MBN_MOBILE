import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';

class AuthOrSeparator extends StatelessWidget {
  const AuthOrSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.textGrey,
            thickness: 1,
          ),
        ),
        SizedBox(width: AppSize.getWidth(16)),
        Text(
    context.tr( "choose_account.or"),
          style: TextStyle(
              fontSize: AppSize.getSize(12),
              fontWeight: FontWeight.w700,
              color: AppColors.textGrey),
        ),
        SizedBox(width: AppSize.getWidth(16)),
        Expanded(
          child: Divider(
            color: AppColors.textGrey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
