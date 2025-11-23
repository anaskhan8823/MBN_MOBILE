part of 'package:dalil_2020_app/features/auth/presentation/screens/login/view.dart';
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () =>
              AppNavigator.push(const ForgetPasswordScreen()),
          child: Text(
            context.tr("login.forget")
            ,style:kTextStyle18UnderLineWhite.copyWith(
            color: AppColors.iconColor,
            decorationColor: AppColors.underlineColor
          ),

          ),
        ),
      ],
    );
  }
}
