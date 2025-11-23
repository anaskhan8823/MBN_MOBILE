part of 'package:dalil_2020_app/features/auth/presentation/screens/select_account_type/view.dart';
class ContinueWithoutLogin extends StatelessWidget {
  const ContinueWithoutLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         AppNavigator.push(const NavUserView());
      },
      child: Text(
      context.tr( "choose_account.continue_without_login"),
        style: kTextStyle18UnderLine
      ),
    );
  }
}
