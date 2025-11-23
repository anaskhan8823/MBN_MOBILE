import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_size.dart';
import '../control/map_stores_cubit.dart';

class DropDownOfMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<MapStoresCubit, MapStoresState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: AppColors.separatingPrimaryBorder),
              color: AppColors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<MapFilter>(
                isExpanded: true,
                items: MapFilter.values
                    .map((item) => DropdownMenuItem<MapFilter>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              item.text(),
                              maxLines: 100,
                              style: TextStyle(
                                fontSize: AppSize.getSize(16),
                                color: state.selected == MapFilter.shops
                                    ? AppColors.buttonPrimaryLight
                                    : AppColors.textLabelSelected,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ))
                    .toList(),
                value: state.selected,
                onChanged: (MapFilter? value) {
                  context.read<MapStoresCubit>().changeSelected(value: value);
                  // setState(() {
                  //   widget.selectedValue = value;
                  // });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  // height: 40,
                  width: 120,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 300,
                  // width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.black,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: AppSize.getSize(25),
                    color: state.selected == MapFilter.shops
                        ? AppColors.buttonPrimaryLight
                        : AppColors.textLabelSelected,
                  ),
                  iconSize: 14,
                  iconEnabledColor: state.selected == MapFilter.shops
                      ? AppColors.buttonPrimaryLight
                      : AppColors.textLabelSelected,
                  iconDisabledColor: AppColors.black,
                ),
              ),
            ),
          );
        });
  }
}
