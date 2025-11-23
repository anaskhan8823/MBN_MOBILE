import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static void push(Widget screen) async {
    await key.currentState?.push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }



  static void replace(Widget screen) async {
    await key.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void remove(Widget screen) async {
    await key.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  static void pop() => key.currentState?.pop();

  static void sheet(Widget sheet) {
    showModalBottomSheet(
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: sheet,
      ),
      context: key.currentState!.context,
    );
  }

  static void dialog(Widget dialog) {
    showDialog(
      builder: (_) => dialog,
      context: key.currentState!.context,
    );
  }
}
