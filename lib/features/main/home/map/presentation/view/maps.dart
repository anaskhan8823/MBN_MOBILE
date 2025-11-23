import 'dart:async';

import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/app_assets.dart';
import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/helper/app_navigator.dart';
import '../../../../../../core/main_keys.dart';
import '../../../../../../core/shared/widgets/custom_icon.dart';
import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_size.dart';
import '../../../../../../models/store_model.dart';
import '../../../../../../models/user_model.dart';
import '../../../../user_details/shop_details/view.dart';
import '../../../contact/presentation/controller/manager_chat_cubit.dart';
import '../../../contact/presentation/view/details_of_chat.dart';
import '../../data/model/map_store_model.dart';
import '../control/map_stores_cubit.dart';
import '../widget/custom_search_anchor_search.dart';
import '../widget/drop_down_of_map.dart';
import '../widget/drop_down_of_representative.dart';
import '../widget/drop_down_of_shops.dart';
import 'package:custom_info_window/custom_info_window.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key, this.showBack = false});
  final bool showBack;
  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  GoogleMapController? gmapController;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isEn = context.locale.languageCode == 'en';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr("navHome.map"),
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: (CachHelper.lang ?? 'ar') == 'ar'
                  ? 'STV'
                  : GoogleFonts.poppins().fontFamily ?? 'Poppins',
              color: AppColors.primary),
        ),
        leading: widget.showBack == true
            ? CustomIcon(
                padding: isEn
                    ? const EdgeInsets.only(left: 16)
                    : const EdgeInsets.only(right: 5),
                onTap: () => AppNavigator.pop(),
                icon: isEn ? AppIcons.arrowLeft : AppIcons.arrowRight,
                width: AppSize.getWidth(24),
                height: AppSize.getHeight(24),
                color: AppColors.iconColor,
              )
            : SizedBox(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 0),
            child: CustomSearchAnchorSearch(),
          ),
        ),
      ),
      body: BlocConsumer<MapStoresCubit, MapStoresState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller0) {
                  controller.complete(controller0);
                  gmapController = controller0;
                  _customInfoWindowController.googleMapController = controller0;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(DEFULT_LAG, DEFULT_LNG),
                  zoom: 5.0,
                ),
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                markers: state.markers.map((marker) {
                  return marker.copyWith(
                    onTapParam: () {
                      _customInfoWindowController.addInfoWindow!(
                        state.selected == MapFilter.shops
                            ? _buildCustomCardShop(marker.markerId.value)
                            : _buildCustomCardRepresentative(
                                marker.markerId.value),
                        marker.position,
                      );
                    },
                  );
                }).toSet(),
                onTap: (position) {
                  _customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!();
                },
              ),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 90,
                width: 190,
              ),
              Positioned(
                top: 10,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.selected == MapFilter.shops
                          ? DropDownOfShops(onClick: (Location? value) async {
                              if (value != null &&
                                  value.longitude != null &&
                                  value.latitude != null) {
                                await gmapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                        target: LatLng(
                                            double.parse(
                                                "${value.latitude ?? 0}"),
                                            double.parse(
                                                "${value.longitude ?? 0}")),
                                        zoom: 10.0), // Adjust zoom level
                                  ),
                                );
                              }
                            })
                          : DropDownOfRepresentative(
                              onClick: (Location? value) async {
                              if (value != null &&
                                  value.longitude != null &&
                                  value.latitude != null) {
                                await gmapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                        target: LatLng(
                                            double.parse(
                                                "${value.latitude ?? 0}"),
                                            double.parse(
                                                "${value.longitude ?? 0}")),
                                        zoom: 10.0), // Adjust zoom level
                                  ),
                                );
                              }
                            }),
                      const SizedBox(width: 20),
                      DropDownOfMap(),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildCustomCardShop(String markerId) {
    final store = context.read<MapStoresCubit>().state.listOfStores.firstWhere(
        (store) =>
            LatLng(double.parse("${store.location?.latitude}"),
                    double.parse("${store.location?.longitude}"))
                .toString() ==
            markerId,
        orElse: () => MapStoresModel());

    if (store.id == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        final isEn = context.locale.languageCode == 'en';

        // AppNavigator.push(StoreDetailsUserView(
        //   mainCategoryName: store.category![0],
        //   subCategoryName: store.subCategory![0],
        //   address: store.contactInfo?.address ?? '',
        //   workTimes: store.workingTimes ?? [],
        //   location: store.location,
        //   phone: store.contactInfo?.mobileNumber ?? '',
        //   storeId: store.id ?? 0,
        //   rating: "${store.rating.toString() ?? "0"}",
        //   storeName:
        //       isEn ? store.storeName!.en ?? '' : store.storeName!.ar ?? '',
        //   storeImage: store.images!.isNotEmpty ? store.images![0] : '',
        // ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        height: 130,
        width: 150,
        decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.tr('deliveryUserView.Restaurants'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 12.sp)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${store.rating ?? ''}".toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 10.sp)),
                    const SizedBox(
                      width: 03,
                    ),
                    const Icon(
                      Icons.star,
                      color: AppColors.primaryLight,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 05,
            ),
            Text(
                context.locale == const Locale("ar")
                    ? (store.storeName?.ar ?? '')
                    : (store.storeName?.en ?? ''),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 10.sp)),
            SizedBox(
              height: 05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  AppSvg.items,
                  color: Colors.white,
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCardRepresentative(String markerId) {
    final store = context
        .read<MapStoresCubit>()
        .state
        .listOfRepresentative
        .firstWhere(
            (store) =>
                LatLng(double.parse("${store.latitude}"),
                        double.parse("${store.longitude}"))
                    .toString() ==
                markerId,
            orElse: () => UserModel());

    if (store.id == null) return const SizedBox();

    return GestureDetector(
      onTap: () {
        context
            .read<MapStoresCubit>()
            .addRepresentative(context: context, representativeUser: store);
        final isEn = context.locale.languageCode == 'en';

        // AppNavigator.push(StoreDetailsUserView(
        //   mainCategoryName: store.category![0],
        //   subCategoryName: store.subCategory![0],
        //   address: store.contactInfo?.address ?? '',
        //   workTimes: store.workingTimes ?? [],
        //   phone: store.contactInfo?.mobileNumber ?? '',
        //   storeId: store.id ?? 0,
        //   rating: num.parse("${store.rating.toString() ?? "0",}"),
        //   storeName:
        //       isEn ? store.storeName!.en ?? '' : store.storeName!.ar ?? '',
        //   storeImage: store.images!.isNotEmpty ? store.images![0] : '',
        // ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        height: 120,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.containerBack,
                  radius: 15,
                  backgroundImage: NetworkImage(store.avatar ?? ''),
                  onBackgroundImageError: (_, __) {},
                  child: (store.avatar == null)
                      ? Image.asset(
                          AppIcons.choosePhoto,
                          fit: BoxFit.scaleDown,
                          height: 15.h,
                          width: 15.h,
                        )
                      : null,
                ),
                Text((store.name ?? ''),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13.sp)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.tr('navHome.chat'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13.sp)),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.textLabelSelected,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
