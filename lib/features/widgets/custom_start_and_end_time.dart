import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';
import '../../core/style/app_size.dart';
class StartAndEndTime extends StatelessWidget {
  const StartAndEndTime({
    super.key,
     this.isWorkDay, required this.label,
      this.onTap
  });
  final bool ?isWorkDay;
  final String label;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap:onTap,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isWorkDay==true ? Colors.grey[900] : const Color(0xff545454),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          CustomSvg(svg: AppSvg.solidTime),
          const SizedBox(width: 8),
          Text(
            label.tr(),
            style: TextStyle(color: Colors.white,
                fontSize: AppSize.getSize(14),
                fontWeight: FontWeight.normal
            ),
          ),
        ],
      ),
    ),
            );
  }
}