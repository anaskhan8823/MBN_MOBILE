import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/dialogs.dart';
import 'package:dalil_2020_app/core/shared/features/user/controllers/user_cubit.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/user/controllers/my_account_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/shared/widgets/auth_appbar.dart';
import '../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import '../../widgets/custpm_store_nav_bar.dart';
import '../controller/stepper_and_add_product_cubit.dart';

class AddProduct extends StatelessWidget {
  const AddProduct(
      {super.key,
      required this.enterScreen,
      required this.storeId,
      this.productId});
  final String enterScreen;
  final int? storeId;
  final int? productId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StepperAndNavAddProductCubit(),
        ),
        BlocProvider(
          create: (_) => StoreAndProductCubit()..getCategories(),
        ),
        BlocProvider(
          create: (_) => UploadPhotoCubit(),
        ),
        BlocProvider(
          create: (_) => MyAccountCubit(),
        ),
      ],
      child: BlocBuilder<StepperAndNavAddProductCubit, int>(
        builder: (context, currentIndex) {
          final cubit = context.read<StepperAndNavAddProductCubit>();
          final addCubit = context.read<StoreAndProductCubit>();
          final uploadCubit = context.read<UploadPhotoCubit>();
          final userCubit = context.read<MyAccountCubit>();
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
              //this screen do 4 functions for 2 users
              //-->edit and add product for shop owner
              //-->edit and add product for productive
              bottomNavigationBar: CustomStoreNavBar(
                color: enterScreen == kProductiveFamilies
                    ? AppColors.primaryProductive
                    : null,
                addProductIndex: currentIndex,
                onNext: () {
                  if (currentIndex == 0) {
                    if (!cubit.formKey.currentState!.validate()) {
                      return;
                    }
                    cubit.next(currentIndex);
                  }
                  //the  functions for productive
                  if (currentIndex == 1 && enterScreen == kProductiveFamilies) {
                    if (!cubit.formKey.currentState!.validate()) {
                      return;
                    }
                    addCubit.addProduct(
                        uploadCubit.imagesList, CachHelper.userId);
                  }
                  //the main  functions for shop owner
                  if (currentIndex == 1 && enterScreen == kShopOwner) {
                    if (!cubit.formKey.currentState!.validate()) {
                      return;
                    }
                    addCubit.addProductForShopOwner(
                        uploadCubit.imagesList, storeId);
                  }
                  if (currentIndex == 1 && enterScreen == kUser) {
                    if (!cubit.formKey.currentState!.validate()) {
                      return;
                    }
                    addCubit.addProductForUser(
                        uploadCubit.imagesList, CachHelper.userId);
                  }
                },
                onBack: () {
                  cubit.backSection(currentIndex);
                },
                index: currentIndex,
              ),
              body: enterScreen != kProductiveFamilies
                  ? cubit.tabsOfProduct[currentIndex]
                  : cubit.tbsOfProductFamilies[currentIndex]);
        },
      ),
    );
  }
}
