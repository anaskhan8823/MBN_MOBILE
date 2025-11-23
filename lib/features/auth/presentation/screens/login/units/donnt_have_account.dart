part of 'package:dalil_2020_app/features/auth/presentation/screens/login/view.dart';
class NotHaveAccount extends StatelessWidget {
  const NotHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
        context.tr( "login.noAccount"),
            style:TextStyle(
              fontSize: AppSize.getSize(18),
              fontWeight: FontWeight.w400,
              color:AppColors.whiteAndBlackColor,
            )
        ),
        SizedBox(width: AppSize.getWidth(3)),
        InkWell(
          onTap: () {
            AppNavigator.push(const SelectAccountTypeScreen());
          },
          child: Text(
            context.tr("login.signUp"),
              style: kTextStyle18UnderLine.copyWith(decorationColor: AppColors.primary)
          ),
        ),
      ],
    );
  }
}
