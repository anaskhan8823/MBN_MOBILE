import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/main/add_product/view.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/helper/dialogs.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../models/store_model.dart';
import '../../../widgets/comments_card.dart';
import '../../../widgets/custom_back_button_in_container.dart';
import '../../../widgets/custom_edit_and_delete_store_buttons.dart';
import '../../../widgets/custom_eye.dart';
import '../../../widgets/custom_name_and_rating.dart';
import '../../../widgets/service_for_shop_owner_in_store_details.dart';
import '../../../widgets/wavy_spacing.dart';
import '../../controller/product_cubit/product_cubit.dart';
import '../../home/units/text_row_see_all.dart';
import '../all_products/view.dart';
import '../edit_store/nav_and_stepper_edit_store.dart';
import 'other_details.dart';
part '../../../widgets/comments_store_section.dart';

class StoreDetailsScreen extends StatelessWidget {
  const StoreDetailsScreen(
      {super.key,
      required this.storeId,
      required this.storeImage,
      required this.storeName,
      required this.endDate,
      required this.rating,
      required this.views,
      required this.location,
      required this.onDelete,
      required this.description,
      required this.workingTimes,
      required this.phone,
      required this.address,
      required this.storeArabicName,
      required this.storeEnglishName,
      required this.storeArabicDesc,
      required this.storeEnglishDesc,
      required this.subCategoryName,
      required this.mainCategoryName,
      this.city,
      this.country,
      this.dialCode,
      required this.products});
  final String storeImage;
  final String storeName;
  final String storeArabicName;
  final String storeEnglishName;
  final Location? location;
  final String storeArabicDesc;
  final String storeEnglishDesc;
  final String endDate;
  final String rating;
  final num views;
  final int storeId;
  final String description;
  final void Function() onDelete;
  final List<WorkingTime> workingTimes;
  final String phone;
  final String address;
  final String subCategoryName;
  final String mainCategoryName;
  final String? city;
  final String? country;
  final String? dialCode;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    bool isEn = CachHelper.lang == 'en';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()..getAllProductsForShop(),
        ),
        BlocProvider(
          create: (context) =>
              StoreAndProductCubit()..getAllCommentsForStore(storeId),
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          leading: CustomBackButtonWithCircleContainer(
              color: AppColors.primary, isEn: isEn),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                child: Image.network(
                  storeImage,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppImages.products);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomNameAndItsRating(
                        rating: rating.toString(),
                        name: storeName,
                        color: AppColors.primary),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'addStore.date'.tr(),
                          style: const TextStyle(
                              color: Colors.orange, fontSize: 12),
                        ),
                        Text(
                          " : $endDate",
                          style: TextStyle(
                              color: AppColors.whiteAndBlackColor,
                              fontSize: 12),
                        ),
                        const Spacer(),
                        CustomEyeView(
                          color: AppColors.primary,
                          views: views,
                          showViewWord: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ServiceForShopOwnerInStoreDetails(
                      category: mainCategoryName,
                      subCategory: subCategoryName,
                    ),
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      AppIcons.wave,
                    ),
                    const SizedBox(height: 20),
                    Text('addProduct.storeDescription'.tr(),
                        style: kTextStyle18iUnderLine),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(
                          color: AppColors.whiteAndGreyColor, fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      height: 40,
                      textColor: Colors.white,
                      title: "addProduct.contact".tr(),
                      onTap: () {
                        AppNavigator.push(OtherDetails(
                          address: address,
                          phone: phone,
                          location: location,
                          workingTimes: workingTimes,
                        ));
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(22)),
                    ),
                    const SizedBox(height: 10),
                    EditAndDeleteButtons(
                      onPressed: () => AppNavigator.push(NavEditStore(
                        storeImage: storeImage,
                        workingTimes: workingTimes,
                        country: country,
                        phoneNumber: phone,
                        city: city,
                        address: address,
                        dialCode: dialCode,
                        subScriptionEndDate: endDate,
                        mainCategoryName: mainCategoryName,
                        subCategoryName: subCategoryName,
                        storeId: storeId,
                        arStoreName: storeArabicName,
                        enStoreName: storeEnglishName,
                        arStoreDesc: storeArabicDesc,
                        enStoreDesc: storeEnglishDesc,
                      )),
                      storeId: storeId,
                      onDelete: onDelete,
                    ),
                    const SizedBox(height: 10),
                    const WavySpacing(),
                    const SizedBox(height: 10),
                    TextSeeAll(
                        showSeeAll: products.isNotEmpty,
                        mainText: "addProduct.products",
                        onPressed: () {
                          AppNavigator.push(AllProductsForStoreShopOwnerView(
                            name: storeName,
                            number: phone,
                            products: products,
                            storeId: storeId,
                          ));
                        }),
                    BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                      if (state is GetProductsSuccess) {
                        final product = state.product;
                        return products.isEmpty
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Text(
                                  "addStore.emptyProducts".tr(),
                                  style: TextStyle(
                                      color: AppColors.whiteAndBlackColor),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.39,
                                child: AllProductsForStoreShopOwnerView(
                                  name: storeName,
                                  number: phone,
                                  padding: 0,
                                  viewFromWhere: kViewFromHome,
                                  storeId: storeId,
                                  showAppBar: false,
                                  crossAxisCount: 1,
                                  scrollDirection: Axis.horizontal,
                                  childAspectRatio: 11 / 7,
                                  products: products,
                                ));
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Text(
                            "addStore.emptyProducts".tr(),
                            style:
                                TextStyle(color: AppColors.whiteAndBlackColor),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    }),
                    const SizedBox(height: 10),
                    CustomButton(
                      iconColored: true,
                      iconColor: Colors.orange,
                      icon: AppIcons.box,
                      height: 40,
                      textColor: AppColors.blackAndWhiteColor,
                      title: "addProduct.newProduct".tr(),
                      onTap: () {
                        AppNavigator.push(AddProduct(
                          enterScreen: kShopOwner,
                          storeId: storeId,
                        ));
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(22)),
                    ),
                    const SizedBox(height: 15),
                    const WavySpacing(),
                    const SizedBox(height: 10),
                    const CommentsStoreSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
