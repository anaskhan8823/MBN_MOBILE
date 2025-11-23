import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/app_size.dart';
import 'cubit/language_cubit.dart';
import '../../core/app_assets.dart';
import '../../core/shared/widgets/custom_svg.dart';

class CustomChangeLang extends StatelessWidget {
  const CustomChangeLang({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: AppSize.getWidth(8)),
        CustomSvg(
          color: AppColors.iconColor,
          svg: AppIcons.lang,
        ),
        SizedBox(width: AppSize.getWidth(8)),
        BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, currentLang) {
                      return DropdownButton<String>(
                        value: currentLang.locale.languageCode,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(
                            AppSize.getSize(16)),
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: AppColors.dropButtonIconColor),
                        hint: Text(
                          currentLang == "ar" ? "ع" : "EN",
                          style: kTextStyle10.copyWith(color: AppColors.dropButtonTextColor)
                        ),
                        onChanged: (String? newValue) async {
                          if (newValue != null  && newValue != currentLang.locale.languageCode) {
                            context.read<LanguageCubit>().changeLanguage(
                                newValue, context);}
                          },
                        items: context.supportedLocales
                            .map((e) => e.languageCode)
                            .map<DropdownMenuItem<String>>(
                              (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                  style: kTextStyle10.copyWith(color: AppColors.dropButtonTextColor)

                                // style: TextStyle(
                                //     color: AppColors.white,
                                //     fontSize: AppSize.getSize(12),
                                //   fontWeight: FontWeight.w400,
                                // ),
                              ),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                ],
              );

    }
  }