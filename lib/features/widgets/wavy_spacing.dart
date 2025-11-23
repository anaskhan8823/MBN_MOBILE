import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/app_assets.dart';

class WavySpacing extends StatelessWidget {
  const WavySpacing({super.key, this.color});
  final Color?color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppIcons.wave,
      colorFilter: ColorFilter.mode(color??AppColors.primary, BlendMode.srcIn),

    );
  }
}
