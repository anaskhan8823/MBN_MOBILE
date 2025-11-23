import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/style/app_size.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/helper/dialogs.dart';
import 'custom_start_and_end_time.dart';

class DayRow extends StatelessWidget {
  final String day;
  final bool isWorkDay;
  final ValueChanged<bool>? onChanged;
  final Function(String value) onStart;
  final Function(String value) onEnd;
  const DayRow(
      {super.key,
      required this.onStart,
      required this.onEnd,
      required this.day,
      required this.isWorkDay,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (_, state) {
        final cubit = context.read<StoreAndProductCubit>();
        final bool isWorkDay = cubit.dayStates[day] ?? false;
        final String? serverStartTime = cubit.serverStartTimes[day];
        final String? serverEndTime = cubit.serverEndTimes[day];
        final String startTime = serverStartTime ?? cubit.startTimes[day] ?? '';
        final String endTime = serverEndTime ?? cubit.endTimes[day] ?? '';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: AppColors.greyAndWhiteWithShadowColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: AppColors.borderContainerColor)),
                child: Row(
                  children: [
                    CustomSvg(
                      svg: AppSvg.date,
                      color: AppColors.iconColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      context.tr(day) ?? "",
                      style: TextStyle(color: AppColors.underlineColor),
                    ),
                    const Spacer(),
                    ToggleButtons(
                      isSelected: [isWorkDay, !isWorkDay],
                      onPressed: (index) {
                        cubit.changeWorkAndHoliday(day, index == 0);
                      },
                      borderRadius: BorderRadius.circular(12),
                      fillColor: isWorkDay ? AppColors.primary : Colors.green,
                      constraints: const BoxConstraints(
                        minWidth: 80,
                        minHeight: 36,
                      ),
                      children: [
                        Text(
                          'addStore.work'.tr(),
                          style: TextStyle(
                              fontSize: AppSize.getSize(14),
                              color:
                                  isWorkDay ? Colors.black : AppColors.primary),
                        ),
                        Text(
                          'addStore.holiday'.tr(),
                          style: TextStyle(
                              fontSize: AppSize.getSize(14),
                              color: !isWorkDay ? Colors.black : Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              if (isWorkDay)
                Row(
                  children: [
                    Expanded(
                      child: StartAndEndTime(
                        onTap: () async {
                          TimeOfDay? pickedTime =
                              await displayTimePicker(context);
                          if (pickedTime != null) {
                            final startValue =
                                "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                            onStart(startValue);
                          }
                        },
                        isWorkDay: isWorkDay,
                        label: startTime,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StartAndEndTime(
                          onTap: () async {
                            TimeOfDay? pickedTime =
                                await displayTimePicker(context);
                            if (pickedTime != null) {
                              final endValue =
                                  "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                              onEnd(endValue);
                            }
                          },
                          isWorkDay: isWorkDay,
                          label: endTime),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
