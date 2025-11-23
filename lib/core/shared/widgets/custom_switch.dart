import 'package:flutter/material.dart';

import '../../app_assets.dart';
import '../../style/app_size.dart';
import 'custom_icon.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key, required this.value, required this.onChange});

  final bool value;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return CustomIcon(
      withColor: true,
      width: AppSize.getWidth(44),
      height: AppSize.getHeight(24),
      onTap: () => onChange(!value),
      icon: value ? AppIcons.switchOn : AppIcons.switchOff,
    );
  }
}
