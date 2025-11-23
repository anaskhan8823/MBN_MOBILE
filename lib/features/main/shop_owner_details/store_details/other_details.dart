import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/models/store_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/main_keys.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import '../../../../core/style/text_style.dart';
import '../../../widgets/custom_start_and_end_time.dart';
part 'package:dalil_2020_app/features/main/shop_owner_details/store_details/units/work_days.dart';

class OtherDetails extends StatelessWidget {
  const OtherDetails(
      {super.key,
      required this.workingTimes,
      required this.phone,
      required this.location,
      required this.address});
  final List<WorkingTime> workingTimes;
  final String phone;
  final String address;
  final Location? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(
        title: 'otherDetails.appBar',
        showLang: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  style: kTextStyle16Orange,
                  text: "otherDetails.phone".tr(),
                  children: [
                    TextSpan(style: kTextStyle14white, text: phone),
                  ]),
            ),
            RichText(
              text: TextSpan(
                  style: kTextStyle16Orange,
                  text: "sign_up.address".tr(),
                  children: [
                    TextSpan(style: kTextStyle14white, text: " : $address"),
                  ]),
            ),
            Text(
              'otherDetails.location'.tr(),
              style: kTextStyle16Orange,
            ),
            SizedBox(
              height: 300.h,
              child: GoogleMap(
                myLocationButtonEnabled: false,
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: (location != null &&
                          location?.longitude != null &&
                          location?.latitude != null)
                      ? LatLng(double.parse("${location?.latitude ?? 0}"),
                          double.parse("${location?.longitude ?? 0}"))
                      : LatLng(DEFULT_LAG, DEFULT_LNG),
                  zoom: 5.0,
                ),
                markers: {
                  Marker(
                    icon: BitmapDescriptor.defaultMarkerWithHue((46.00)),
                    markerId: MarkerId(LatLng(
                            double.parse("${location?.latitude ?? 0}"),
                            double.parse("${location?.longitude ?? 0}"))
                        .toString()),
                    position: (location != null &&
                            location?.longitude != null &&
                            location?.latitude != null)
                        ? LatLng(double.parse("${location?.latitude ?? 0}"),
                            double.parse("${location?.longitude ?? 0}"))
                        : LatLng(DEFULT_LAG, DEFULT_LNG),
                  )
                },
                onCameraMove: (position) {
                  // context.read<MapCubit>().updateLocation(position.target);
                },
                onMapCreated: (GoogleMapController controller0) {
                  // setState(() {
                  //   controller.complete(controller0);
                  //   gmapController = controller0;
                  // });
                },
              ),
            ),
            Text('otherDetails.work'.tr(), style: kTextStyle18iUnderLine),
            Column(
              children: workingTimes.map((day) {
                final daysOfWeek = [
                  "Saturday",
                  "Sunday",
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday"
                ];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: AppColors.greyAndWhiteWithShadowColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(
                                color: AppColors.borderContainerColor)),
                        child: Row(children: [
                          CustomSvg(
                            svg: AppSvg.date,
                            color: AppColors.iconColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            daysOfWeek[day
                                .dayOfWeek!], // assuming day.dayOfWeek is 0–6
                            style: TextStyle(color: AppColors.underlineColor),
                          ),
                          const Spacer(),
                          Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: day.isWorkingDay == true
                                      ? AppColors.primary
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  day.isWorkingDay == true ? 'work' : 'Holiday',
                                  style: TextStyle(
                                      fontSize: AppSize.getSize(14),
                                      color: Colors.black),
                                ),
                              )),
                        ]),
                      ),
                      const SizedBox(height: 8),
                      day.isWorkingDay == true
                          ? Row(
                              children: [
                                Expanded(
                                  child: StartAndEndTime(
                                    isWorkDay: day.isWorkingDay,
                                    label:
                                        day.openingTime ?? 'addStore.startTime',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: StartAndEndTime(
                                      isWorkDay: day.isWorkingDay,
                                      label: day.closingTime ??
                                          'addStore.endTime '),
                                ),
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
