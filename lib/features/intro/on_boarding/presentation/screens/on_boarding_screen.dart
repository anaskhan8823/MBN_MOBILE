import 'package:dalil_2020_app/core/style/text_style.dart';
import 'package:dalil_2020_app/features/intro/on_boarding/presentation/controllers/on_boarding_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import '../controllers/on_boarding_state.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnBoardingCubit()..initVideo(),
      child: BlocBuilder<OnBoardingCubit, OnBoardingStates>(
        builder: (context, state) {
          final cubit = OnBoardingCubit.get(context);
          return Scaffold(
            body: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                if (cubit.controller.value.isInitialized)
                  VideoPlayer(cubit.controller)
                else
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        cubit.skipVideo();
                      },
                      style: ButtonStyle(
                          textStyle: WidgetStatePropertyAll(
                              kTextStyle16Orange.copyWith(fontSize: 22))),
                      child: Text("skip".tr())),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
