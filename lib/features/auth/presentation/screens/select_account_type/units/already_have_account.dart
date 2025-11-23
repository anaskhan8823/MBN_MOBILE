part of 'package:dalil_2020_app/features/auth/presentation/screens/select_account_type/view.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});
  @override
  Widget build(BuildContext context) {
    return   Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
    context.tr("choose_account.have_account"),
              style: kTextStyle18White.copyWith(
                color: AppColors.labelInputColor,

              )
          ),
          SizedBox(width: AppSize.getWidth(3)),
          GestureDetector(
            onTap: () => AppNavigator.replace(const SignInScreen()),
            child: Text(
    context.tr("choose_account.login"),
              style: kTextStyle18UnderLine,
            ),

          ),]);
  }
}
