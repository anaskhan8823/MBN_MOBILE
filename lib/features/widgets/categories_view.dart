import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:flutter/material.dart';
class CategoriesView extends StatelessWidget {
   CategoriesView({super.key});
    final List<String>categoryCards=
    [AppImages.shopsCard,AppImages.rentCard,AppImages.sellCard,AppImages.productiveCard,AppImages.delegateCard];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AuthAppbar(
        showLang: false,
        title: "Categories",
      ),
      body: ListView.builder(
        itemCount: categoryCards.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(categoryCards[index]),
            );

          },
      ),
    );
  }
}
