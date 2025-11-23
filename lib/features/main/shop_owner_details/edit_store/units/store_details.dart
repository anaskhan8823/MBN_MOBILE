import 'package:dalil_2020_app/core/helper/app_loading.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../models/store_model.dart';
import '../../../../widgets/custom_day_work_and_holiday.dart';
import '../../../controller/store_and_product_cubit/add_store_cubit.dart';

class EditStoreWorkTimes extends StatelessWidget {
  const EditStoreWorkTimes({super.key, required this.workingTimes});
  final List<WorkingTime> workingTimes;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoreAndProductCubit>();

    // Initialize cubit states if not already
    cubit.initializeDayStates(workingTimes);

    return BlocBuilder<StoreAndProductCubit, StoreAndProductState>(
      builder: (_, state) {
        if (state is AddStoreLoading) return const AppLoading();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'addStore.chooseWorkHoliday'.tr(),
                style: kTextStyle18UnderLine.copyWith(
                  decorationColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: workingTimes.map((day) {
                    return DayRow(
                      day: cubit.days[day.dayOfWeek!].toString(),
                      isWorkDay: workingTimes[day.dayOfWeek!].isWorkingDay!,
                      onChanged: (value) {
                        cubit.changeWorkAndHoliday(day, value);
                      },
                      onStart: (String value) {
                        context
                            .read<StoreAndProductCubit>()
                            .pickStartTime(cubit.days[day.dayOfWeek!], value);
                      },
                      onEnd: (String value) {
                        context
                            .read<StoreAndProductCubit>()
                            .pickEndTime(cubit.days[day.dayOfWeek!], value);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
