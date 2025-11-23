import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../style/app_colors.dart';
import '../../style/app_size.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatefulWidget {
  final double? width;
  final double? height;
  final Color? color;
  final String? headLine;
  final String dropDownHint;
  final TextStyle? dropDownHintTextStyle;
  String? selectedValue;
  final List<String?>? items;
  final Function(String? value) ?onItemChanged;
  CustomDropDown({super.key,this.width,this.height,this.selectedValue,this.headLine="",
    required this.dropDownHint,
    this.dropDownHintTextStyle,
    this.items=const [''],required  this.onItemChanged, this.color});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headLine != null) ...[
          Text(
            widget.headLine!,
            style: TextStyle(
              fontSize: AppSize.font(14),
              fontWeight: FontWeight.w700,
              color: AppColors.typographyHeading,
            ),
          ),
          SizedBox(height: AppSize.getHeight(6)),
        ],
        Container(
          width: widget.width??double.infinity,
          height:widget.height?? AppSize.getHeight(48),
          padding: EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: AppColors.separatingPrimaryBorder),
            color:Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                widget.dropDownHint,
                style: TextStyle(
                  fontSize: AppSize.getSize(14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.typographyHeading,
                ),
              ),
              items: widget.items
                  ?.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    item??"",
                    maxLines: 100,
                    style: widget.dropDownHintTextStyle??TextStyle(
                      fontSize: AppSize.getSize(16),
                      color: AppColors.typographyHeading,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )).toList(),
              value: widget.selectedValue,
              onChanged:widget.onItemChanged?? (String? value) {
                setState(() {
                  widget.selectedValue = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                // width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
              iconStyleData: IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down_sharp,
                  size: AppSize.getSize(25),
                  color: AppColors.typographySubtitle,
                ),
                iconSize: 14,
                iconEnabledColor:AppColors.typographySubtitle,
                iconDisabledColor: AppColors.typographySubtitle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
