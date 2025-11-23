import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  const CustomStepper(
      {super.key, required this.onStepReached, required this.activeStep});
  final void Function(int)? onStepReached;
  final int activeStep;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: EasyStepper(
        activeStep: activeStep,
        enableStepTapping: false,
        showStepBorder: false,
        activeStepBorderColor: AppColors.primary,
        finishedStepBackgroundColor: AppColors.primary,
        activeStepBackgroundColor: AppColors.primary,
        defaultStepBorderType: BorderType.normal,
        unreachedStepBackgroundColor: Colors.grey[300],
        stepRadius: 12,
        finishedStepBorderColor: Colors.deepOrange,
        finishedStepTextColor: Colors.deepOrange,
        activeStepIconColor: Colors.deepOrange,
        showLoadingAnimation: false,
        lineStyle: LineStyle(
            unreachedLineColor: Colors.grey[300],
            lineType: LineType.dashed,
            lineLength: 50),
        steps: [
          EasyStep(
            customStep: const SizedBox(),
            customTitle: Text(
              'addStore.information'.tr(),
              style: kTextStyle10.copyWith(
                  color: activeStep == 0
                      ? AppColors.primary
                      : AppColors.whiteAndBlackColor),
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            customStep: const SizedBox(),
            customTitle: Text(
              'addStore.details'.tr(),
              style: kTextStyle10.copyWith(
                  color: activeStep == 1
                      ? AppColors.primary
                      : AppColors.whiteAndBlackColor),
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            customStep: const SizedBox(),
            customTitle: Text(
              'addStore.categories'.tr(),
              style: kTextStyle10.copyWith(
                  color: activeStep == 2
                      ? AppColors.primary
                      : AppColors.whiteAndBlackColor),
              textAlign: TextAlign.center,
            ),
          ),
          EasyStep(
            customStep: const SizedBox(),
            customTitle: Text(
              'addStore.time'.tr(),
              style: kTextStyle10.copyWith(
                  color: activeStep == 3
                      ? AppColors.primary
                      : AppColors.whiteAndBlackColor),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        onStepReached: onStepReached,
      ),
    );
  }
}
