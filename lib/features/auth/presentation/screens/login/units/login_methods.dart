import 'package:flutter/cupertino.dart';
import '../../../../../../core/app_assets.dart';
import '../../../../../../core/style/app_size.dart';
import 'card_sign_in.dart';

class LoginMethods extends StatelessWidget {
  const LoginMethods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      // CardSignInMethods(
      //   method: AppSvg.appleLogin,
      // ),
      CardSignInMethods(
        method: AppSvg.googleLogin,
      ),
      // CardSignInMethods(
      //     image: Image.asset("assets/images/nafaz.png",fit: BoxFit.cover,
      //     height:AppSize.getHeight(20),
      //     )
      // ),
    ]);
  }
}
