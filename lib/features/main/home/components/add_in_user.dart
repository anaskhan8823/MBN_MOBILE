import 'package:dalil_2020_app/core/shared/widgets/auth_appbar.dart';
import 'package:flutter/material.dart';

class AddInHomeUser extends StatelessWidget {
  const AddInHomeUser({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AuthAppbar(
          title: 'navHome.addShop', hideBackButton: true, showLang: false),
      body: Column(
        children: [
          Center(
            child: Text("hello"),
          )
        ],
      ),
    );
  }
}
