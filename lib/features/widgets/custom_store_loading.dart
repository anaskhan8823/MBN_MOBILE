import 'package:dalil_2020_app/features/widgets/storeCard.dart';
import 'package:flutter/material.dart';

import '../../core/style/app_size.dart';

class StoresLoading extends StatelessWidget {
  const StoresLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.32,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.4,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSize.getHeight(8),
              horizontal: AppSize.getWidth(4),
            ),
            child: const StoreCard(
              imageUrl: '',
              products: 0.0,
              rating: "100",
              storeName: '',
              views: 0.0,
            ),
          );
        },
      ),
    );
  }
}
