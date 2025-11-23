import 'dart:io';
import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/helper/dialogs.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/controller/product_cubit/product_cubit.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/edit_product/units/edit_product_form.dart';
import 'package:dalil_2020_app/features/main/edit_product/units/edit_product_salary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared/widgets/auth_appbar.dart';
import '../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import '../../widgets/custpm_store_nav_bar.dart';
import '../controller/stepper_and_add_product_cubit.dart';

class EditProduct extends StatelessWidget {
  const EditProduct(
      {super.key,
      required this.enterScreen,
      required this.storeId,
      this.productId,
      required this.arabicName,
      required this.englishName,
      required this.arabicDescription,
      required this.englishDescription,
      required this.saleType,
      required this.mainCategory,
      required this.subCategory,
      required this.price,
      required this.priceAfterDisc,
      required this.initialImages,
      this.disctype,
      this.discvalue});
  final String enterScreen;
  final int? storeId;
  final int? productId;
  final String arabicName;
  final String englishName;
  final String arabicDescription;
  final String englishDescription;
  final String saleType;
  final String mainCategory;
  final String subCategory;
  final List<File> initialImages;
  final String price;
  final String priceAfterDisc;
  final String? disctype;
  final String? discvalue;

  @override
  Widget build(BuildContext context) {
    final tbsOfProductFamilies = <Widget>[
      EditProductForm(
        color: enterScreen != kProductiveFamilies
            ? null
            : AppColors.primaryProductive,
        initialImages: initialImages,
        arabicName: arabicName,
        englishName: englishName,
        arabicDescription: arabicDescription,
        englishDescription: englishDescription,
      ),
      EditProductSalary(
        color: enterScreen != kProductiveFamilies
            ? null
            : AppColors.primaryProductive,
        subCategory: subCategory,
        priceAfterDisc: priceAfterDisc,
        price: price,
        mainCategory: mainCategory,
        saleType: saleType,
        disctype: disctype,
        discvalue: discvalue,
      ),
    ];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StepperAndNavAddProductCubit(),
        ),
        BlocProvider(
          create: (_) =>
              ProductCubit()..getProductDetailsForProductive(productId),
        ),
        BlocProvider(
          create: (_) => StoreAndProductCubit()..getCategories(),
        ),
        BlocProvider(
          create: (_) => UploadPhotoCubit(),
        ),
      ],
      child: BlocBuilder<StepperAndNavAddProductCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<StepperAndNavAddProductCubit>();
          final addCubit = context.read<StoreAndProductCubit>();
          final uploadCubit = context.read<UploadPhotoCubit>();
          return Scaffold(
              appBar: AuthAppbar(
                color: enterScreen == kProductiveFamilies
                    ? AppColors.primaryProductive
                    : null,
                onTap: () {
                  displayDiscardChangesSheetSheet(
                    context,
                    enterScreen == kProductiveFamilies
                        ? AppColors.primaryProductive
                        : null,
                  );
                },
                showLang: false,
                title: "homeShopOwner.productDetails",
              ),
              bottomNavigationBar: CustomStoreNavBar(
                color: enterScreen == kProductiveFamilies
                    ? AppColors.primaryProductive
                    : null,
                addProductIndex: currentIndex,
                onNext: () {
                  if (currentIndex == 0) {
                    cubit.next(currentIndex);
                  }
                  //the main  functions for productive
                  if (currentIndex == 1 && enterScreen == kProductiveFamilies) {
                    addCubit.editProductForProductive(
                        productId, uploadCubit.imagesList);
                  }
                  //the main  functions for shop owner
                  if (currentIndex == 1 && enterScreen == kShopOwner) {
                    addCubit.editProductForShopOwner(
                        productId!, uploadCubit.imagesListsEdit, storeId!);
                  }
                  if (currentIndex == 1 && enterScreen == kUser) {
                    addCubit.editProductForUser(
                        productId, uploadCubit.imagesListsEdit);
                  }
                },
                onBack: () {
                  cubit.backSection(currentIndex);
                },
                index: currentIndex,
              ),
              body: tbsOfProductFamilies[currentIndex]);
        },
      ),
    );
  }
}
