import 'package:flutter/material.dart';

import '../../style/app_size.dart';

class CustomGridList extends StatelessWidget {
  const CustomGridList({
    super.key,
    this.padding,
    this.physics,
    this.shrinkWrap,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Widget Function(int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      padding: padding,
      shrinkWrap: shrinkWrap ?? false,
      itemCount: (itemCount / 3).ceil(),
      itemBuilder: (_, rowIndex) {
        int startIndex = rowIndex * 3;
        bool hasHalfItems = (startIndex + 1 < itemCount);
        return Column(
          children: [
            rowIndex % 2 == 0 ?
            Row(
              children: [
                Expanded(child: itemBuilder(startIndex)),
                itemBuilder(startIndex),
              ],
            )
                :
            Row(
              children: [
                itemBuilder(startIndex),
                Expanded(child: itemBuilder(startIndex)),
              ],
            ),
            SizedBox(height: AppSize.getHeight(16)),
            if (hasHalfItems) ...[
              Row(
                children: [
                  Expanded(child: itemBuilder(startIndex + 1)),
                  SizedBox(width: AppSize.getWidth(8)),
                  (startIndex + 2 < itemCount)
                      ? Expanded(child: itemBuilder(startIndex + 2))
                      : SizedBox(),
                  SizedBox(width: AppSize.getWidth(8)),
                  (startIndex + 2 < itemCount)
                      ? Expanded(child: itemBuilder(startIndex + 2))
                      : SizedBox(),
                ],
              ),
              SizedBox(height: AppSize.getHeight(12)),
            ],
          ],
        );
      },
    );
  }
}
