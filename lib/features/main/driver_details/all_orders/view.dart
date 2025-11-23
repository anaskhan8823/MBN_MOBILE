import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../../core/style/app_size.dart';
import '../../../widgets/card_driver_item.dart';
import '../../../widgets/custom_drop_button.dart';

class AllOrdersView extends StatelessWidget {
  const AllOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AuthAppbar(
          title: "My Orders",
          hideBackButton: true,
          color: AppColors.primaryDriver,
          showLang: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
              child: CustomDropButton(
                color: AppColors.primaryDriver,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.primaryDriver)),
                dropButton: DropdownButton<int>(
                  style: const TextStyle(color: Colors.white),
                  icon: const SizedBox(),
                  underline: const SizedBox(),
                  // value: cubit.selectedCategoryId,
                  hint: Row(
                    spacing: 5,
                    children: [
                      // CustomSvg(svg: AppSvg.saleType,color:color?? AppColors.iconColor,),
                      Text(
                        "     CURRENT ORDERS",
                        style: TextStyle(color: AppColors.primaryDriver),
                      ),
                    ],
                  ),
                  items: const [],
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
          heightAppBar: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // AppNavigator.push(const ProductDetailsView());
                },
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: AppSize.getHeight(4)),
                    child: const CardDriverItem(
                      name: "mohammed",
                      address: "elgharbia",
                    )),
              );
            },
          ),
        ));
  }
}
