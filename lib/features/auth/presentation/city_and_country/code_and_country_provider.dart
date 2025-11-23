import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/location_cubit.dart';
import 'widgets/codeCountry_drop_button.dart';
import 'widgets/country_drop_button.dart';

class CodeAndCountryDropButton extends StatelessWidget {
  const CodeAndCountryDropButton(
      {super.key,
      this.codeAndNameOfCountry = true,
      this.onChanged,
      this.value,
      this.padding,
      this.onChange,
      this.values,
      this.isauth,
      required this.label,
      this.color,
      this.dialCode});
  final bool codeAndNameOfCountry;
  final bool? isauth;
  final void Function(int?)? onChanged;
  final void Function(String?)? onChange;
  final int? value;
  final String? values;
  final String label;
  final Color? color;
  final String? dialCode;

  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit()..getCountryAndDialCode(),
      child:
          BlocBuilder<LocationCubit, LocationState>(builder: (context, state) {
        final cubit = context.read<LocationCubit>();
        return codeAndNameOfCountry
            ? CodeDropButton(
                cubit: cubit,
                onChange: onChange,
                values: values,
                dialCode: dialCode,
              )
            : CountryDropButton(
                isauth: isauth ?? false,
                color: color ?? AppColors.primary,
                label: label,
                cubit: cubit,
                onChanged: onChanged,
                value: cubit.countriesAndCode.any((e) => e.id == value)
                    ? value
                    : null,
              );
      }),
    );
  }
}
