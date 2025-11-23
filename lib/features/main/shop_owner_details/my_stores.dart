import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/features/main/user_details/shop_details/view.dart';
import 'package:dalil_2020_app/features/widgets/storeCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_assets.dart';
import '../../../core/style/app_colors.dart';
import '../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../home/components/home_user/control/home_user_cubit.dart';
import '../home/map/data/model/map_store_model.dart';

class MyStores extends StatelessWidget {
  const MyStores({
    super.key,
    required this.homeOfUser,
    this.indexOfTap,
  });
  final bool homeOfUser;
  final int? indexOfTap;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeUserCubit, HomeUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<MapStoresModel> list = indexOfTap == 0
              ? state.listOfStoresMostVisited
              : indexOfTap == 1
                  ? state.listOfStoresFeatured
                  : state.listOfStoresHighestRated;
          return state.requestState == RequestStateEnum.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    // strokeWidth: 3,
                    color: AppColors.buttonPrimaryLight,
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 3.w / 2.5.h),
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final isEn = context.locale.languageCode == 'en';

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        child: StoreCard(
                          imageUrl: (list[index].images?.isNotEmpty == true)
                              ? (list[index].images?.first ?? '')
                              : '',
                          products: list[index].products ?? 0,
                          rating: "${list[index].rating ?? 0}",
                          storeName: isEn
                              ? list[index].storeName?.en ?? ''
                              : list[index].storeName?.ar ?? '',
                          views: 120,
                        ),
                        onTap: () {
                          // worktimelocaion
                          AppNavigator.push(StoreDetailsUserView(
                            mainCategoryName:
                                list[index].category?.isNotEmpty == true
                                    ? list[index].category![0]
                                    : '',
                            subCategoryName:
                                list[index].subCategory?.isNotEmpty == true
                                    ? list[index].subCategory![0]
                                    : '',
                            address: list[index].contactInfo?.address ?? '',
                            workTimes: list[index].workingTimes ?? [],
                            location: list[index].location,
                            phone: list[index].contactInfo?.mobileNumber ?? '',
                            storeId: list[index].id ?? 0,
                            rating: list[index].rating.toString() ?? "0",
                            storeName: isEn
                                ? list[index].storeName?.en ?? ''
                                : list[index].storeName?.ar ?? '',

                            storeImage: "",
                            // (list[index].images != null &&
                            //         list[index].images!.isNotEmpty)
                            //     ? list[index].images![0].url ?? ''
                            //     : '',
                          ));
                        },
                      ),
                    );
                  },
                );
        });
  }
}
