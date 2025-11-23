import 'package:flutter/material.dart';
import '../../../../core/app_assets.dart';
import '../../../../core/helper/app_navigator.dart';
import '../../../../core/shared/widgets/custom_svg.dart';
import '../screens/login/tawk_chat_screen.dart';

class CustomFloatingButton extends StatelessWidget {
  CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 2,
      backgroundColor: const Color(0xcbc09e78),
      onPressed: _launchUrl,
      child: CustomSvg(
        svg: AppIcons.chat,
      ),
    );
  }

  Future<void> _launchUrl() async {
    AppNavigator.push(TawkChatScreen());
  }
}
