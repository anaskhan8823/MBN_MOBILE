import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinner_time_picker/flutter_spinner_time_picker.dart';
import 'package:rate/rate.dart';
import '../../features/widgets/customOutlineButton.dart';
import '../style/app_colors.dart';
import '../style/app_size.dart';
import '../style/text_style.dart';
import '../utils.dart';

Future displayDeleteSheet(BuildContext context, onPress) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: AppSize.padding(vertical: 24, start: 15),
          decoration: BoxDecoration(
              color: AppColors.greyAndWhiteWithShadowColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.primary)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("myProfile.deleteAccount".tr(), style: kTextStyle16Orange),
              const SizedBox(height: 10),
              Text("myProfile.sure".tr(), style: kTextStyle16white),
              const SizedBox(height: 15),
              Row(spacing: AppSize.getWidth(19), children: [
                CustomOutlinedButton(
                  label: "myProfile.cancel",
                  side: BorderSide(color: AppColors.primary),
                  backgroundColor: AppColors.greyAndWhiteWithShadowColor,
                  labelColor: AppColors.primary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CustomOutlinedButton(
                    label: "myProfile.confirm",
                    backgroundColor: const Color(0xff820303),
                    side: BorderSide(color: Colors.transparent),
                    labelColor: AppColors.white,
                    onPressed: onPress)
              ])
            ],
          ),
        ),
      );
    },
  );
}

Future showRatingBottomSheet(
    BuildContext context,
    void Function(double) onChangedRate,
    void Function() onTap,
    TextEditingController comment) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Text(
                'rate'.tr(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Rate(
                iconSize: 20,
                color: AppColors.primary,
                onChange: onChangedRate,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: TextField(
                focusNode: FocusNode(),
                controller: comment,
                style: TextStyle(color: AppColors.whiteAndBlackColor),
                decoration: InputDecoration(
                  hintText: 'addComm'.tr(),
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                maxLines: 4,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: CustomButton(
                title: 'addStore.confirm',
                onTap: onTap,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ),
  );
}

Future displayTimePicker(BuildContext context) {
  return showSpinnerTimePicker(context,
      title: '',
      backgroundColor: AppColors.blackAndWhiteColor,
      spinnerHeight: 200,
      foregroundColor: AppColors.black,
      okButtonLabel: 'addStore.pickTime'.tr(),
      spinnerBgColor: AppColors.blackAndGreyColor,
      is24HourFormat: false,
      selectedTextStyle: TextStyle(
          color: AppColors.primary,
          fontSize: AppSize.getSize(20),
          fontWeight: FontWeight.bold),
      nonSelectedTextStyle: TextStyle(
          fontSize: AppSize.getSize(18), fontWeight: FontWeight.normal));
}

Future displayDeleteStoreSheet(
    BuildContext context, Color? color, void Function()? onPressed) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: AppSize.padding(vertical: 15, start: 15, horizontal: 10),
          decoration: BoxDecoration(
              color: AppColors.blackAndWhiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color ?? AppColors.primary, width: 2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("addStore.deleteStore".tr(),
                  style: kTextStyle16Orange.copyWith(
                      color: color ?? AppColors.primary)),
              const SizedBox(height: 10),
              Text("addStore.delete".tr(), style: kTextStyle14white),
              const SizedBox(height: 15),
              Row(spacing: AppSize.getWidth(19), children: [
                CustomOutlinedButton(
                  label: "myProfile.cancel",
                  side: BorderSide(color: color ?? AppColors.primary),
                  backgroundColor: AppColors.blackAndWhiteColor,
                  labelColor: color ?? AppColors.primary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomOutlinedButton(
                      side: const BorderSide(color: Colors.transparent),
                      label: "myProfile.confirm",
                      backgroundColor: const Color(0xff820303),
                      labelColor: AppColors.white,
                      onPressed: onPressed),
                )
              ])
            ],
          ),
        ),
      );
    },
  );
}

Future displaySendCode(BuildContext context, Color? color) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: AppSize.padding(vertical: 15, start: 15, horizontal: 10),
          decoration: BoxDecoration(
              color: AppColors.blackAndWhiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color ?? AppColors.primary, width: 2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  textAlign: TextAlign.center,
                  "ok".tr(),
                  style: kTextStyle16Orange.copyWith(
                      color: color ?? AppColors.primary)),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}

Future displayDeleteProductSheet(
    BuildContext context, Color? color, void Function()? onDelete) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: AppSize.padding(vertical: 24, start: 15),
          decoration: BoxDecoration(
              color: AppColors.blackAndWhiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color ?? AppColors.primary, width: 2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("addProduct.delete".tr(),
                  style: kTextStyle16Orange.copyWith(
                      color: color ?? AppColors.primary)),
              const SizedBox(height: 10),
              Text("addProduct.sureDelete".tr(), style: kTextStyle14white),
              const SizedBox(height: 15),
              Row(spacing: AppSize.getWidth(19), children: [
                CustomOutlinedButton(
                  label: "myProfile.cancel",
                  side: BorderSide(color: color ?? AppColors.primary),
                  backgroundColor: AppColors.blackAndWhiteColor,
                  labelColor: color ?? AppColors.primary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CustomOutlinedButton(
                    side: const BorderSide(color: Colors.transparent),
                    label: "myProfile.confirm",
                    backgroundColor: const Color(0xff820303),
                    labelColor: AppColors.white,
                    onPressed: onDelete)
              ])
            ],
          ),
        ),
      );
    },
  );
}

Future displayDiscardChangesSheetSheet(BuildContext context, Color? color) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: AppSize.padding(vertical: 24, start: 15),
          decoration: BoxDecoration(
              color: AppColors.blackAndWhiteColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: color ?? AppColors.primary, width: 2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "addProduct.discard".tr(),
                style: kTextStyle16Orange.copyWith(
                  color: color ?? AppColors.primary,
                ),
              ),
              const SizedBox(height: 10),
              Text("addProduct.sure".tr(),
                  style: kTextStyle14white, textAlign: TextAlign.center),
              const SizedBox(height: 15),
              Row(spacing: AppSize.getWidth(19), children: [
                CustomOutlinedButton(
                  label: "myProfile.cancel",
                  side: BorderSide(color: color ?? AppColors.primary),
                  backgroundColor: AppColors.blackAndWhiteColor,
                  labelColor: color ?? AppColors.primary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CustomOutlinedButton(
                    side: const BorderSide(color: Colors.transparent),
                    label: "myProfile.confirm",
                    backgroundColor: const Color(0xff820303),
                    labelColor: AppColors.white,
                    onPressed: () {
                      AppNavigator.push(Utils.getUser);
                    })
              ])
            ],
          ),
        ),
      );
    },
  );
}
