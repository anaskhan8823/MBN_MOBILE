import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/style/app_colors.dart';
import '../../../../../../core/style/app_size.dart';
import '../../../../../../models/store_model.dart';
import '../../data/model/map_store_model.dart';
import '../control/map_stores_cubit.dart';

class DropDownOfShops extends StatelessWidget {
  final Function(Location? location) onClick;

  const DropDownOfShops({super.key, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapStoresCubit, MapStoresState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: AppColors.separatingPrimaryBorder),
              color: state.selected == MapFilter.shops
                  ? AppColors.buttonPrimaryLight
                  : AppColors.textLabelSelected,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<int>(
                isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    context.tr('deliveryUserView.Restaurants'),
                    maxLines: 100,
                    style: TextStyle(
                      fontSize: AppSize.getSize(16),
                      color: AppColors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                items: state.listOfStores
                    .map((item) => DropdownMenuItem<int>(
                          value: item.id,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              context.locale == const Locale("ar")
                                  ? (item.storeName?.ar ?? '')
                                  : (item.storeName?.en ?? ''),
                              maxLines: 100,
                              style: TextStyle(
                                fontSize: AppSize.getSize(16),
                                color: AppColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ))
                    .toList(),
                value: state.selectedShop,
                onChanged: (int? value) {
                  context
                      .read<MapStoresCubit>()
                      .changeSelectedShop(value: value);
                  if (value != null) {
                    List<MapStoresModel> listOfStores = state.listOfStores
                        .where((ele) => ele.id == value)
                        .toList();
                    if (listOfStores.isNotEmpty) {
                      Location? location = listOfStores.first.location;
                      onClick(location);
                    }
                  }
                  // setState(() {
                  //   widget.selectedValue = value;
                  // });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  // height: 40,
                  width: 150,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 300,
                  // width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: state.selected == MapFilter.shops
                        ? AppColors.buttonPrimaryLight
                        : AppColors.textLabelSelected,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: AppSize.getSize(25),
                    color: AppColors.black,
                  ),
                  iconSize: 14,
                  iconEnabledColor: AppColors.black,
                  iconDisabledColor: AppColors.black,
                ),
              ),
            ),
          );
        });
  }
}
