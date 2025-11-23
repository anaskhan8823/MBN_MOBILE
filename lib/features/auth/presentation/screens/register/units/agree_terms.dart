
part of 'package:dalil_2020_app/features/auth/presentation/screens/register/units/sign_up_form.dart';
class AgreeTermsWidget extends StatelessWidget {
  const AgreeTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit,AuthStates>(
      builder:(_, state) {
        final cubit = AuthCubit.get(context);
        return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            activeColor: AppColors.primary,
            value: cubit.isAgreedToTerms,
            onChanged: (value) {
              cubit.agreeToTerms();
            },
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: 'sign_up.by_click'.tr(),
                style: kTextStyle14white.copyWith(
                  color: AppColors.labelInputColor
                ),
                children: [
                  TextSpan(
                    text: 'sign_up.terms'.tr(),
                    style:kTextStyle14whiteUnderLine,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {},
                  ),
                  TextSpan(
                      text: 'sign_up.and_that_you'.tr(),
                    style: kTextStyle14white.copyWith(
                        color: AppColors.labelInputColor
                    ),
                  ),
                  TextSpan(
                    text: 'sign_up.policy'.tr(),
                    style:kTextStyle14whiteUnderLine,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      );
      },
    );

  }
}
