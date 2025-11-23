import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/cache/cache_helper.dart';
import '../../core/style/app_colors.dart';

class CustomUserProfileImage extends StatelessWidget {
  const CustomUserProfileImage({super.key, this.color, this.url});
  final Color? color;
  final String? url;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
          border: Border.all(color: color ?? AppColors.primary),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: CachHelper.image == null
          ? SizedBox(
              child: Image.asset(
              AppIcons.choosePhoto,
              fit: BoxFit.scaleDown,
            ))
          : ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(
                url ?? CachHelper.image!.toString(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppIcons.choosePhoto,
                    fit: BoxFit.scaleDown,
                  );
                },
              ),
            ),
    );
  }
}
