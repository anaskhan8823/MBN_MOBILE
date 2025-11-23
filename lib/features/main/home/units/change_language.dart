import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:dalil_2020_app/core/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/language/cubit/language_cubit.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(
        showLang: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            final cubit = context.read<LanguageCubit>();
            return Column(
              spacing: 15,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    onTap: () {
                      cubit.changeLanguage('ar', context);
                      cubit.restartApplication();
                    },
                    title: "العربية"),
                CustomButton(
                    onTap: () {
                      cubit.changeLanguage('en', context);
                      cubit.restartApplication();
                    },
                    title: "English")
              ],
            );
          },
        ),
      ),
    );
  }
}
