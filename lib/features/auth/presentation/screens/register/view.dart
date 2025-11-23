import 'package:dalil_2020_app/core/app_assets.dart';
import 'package:dalil_2020_app/core/helper/app_navigator.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/auth/presentation/city_and_country/cubit/location_cubit.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dalil_2020_app/features/auth/presentation/controllers/auth_cubit.dart';
import '../../../../../core/shared/widgets/auth_appbar.dart';
import '../../../../../core/shared/widgets/container_with_background_image.dart';
import '../../../../../core/style/app_size.dart';
import '../../../../controller/upload_profie_image_cubit/upload_photo_cubit.dart';
import '../../../data/enums/user_type_enum.dart';
import '../../../data/repo/auth_repo_impel.dart';
import '../../controllers/map_cubit.dart';
import 'units/sign_up_form.dart';
import 'units/upload_photo_card.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.userTypeEnum});
  final UserTypeEnum userTypeEnum;
  @override
  Widget build(BuildContext context) {
    bool isDark = AppColors.isDark();
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthCubit(AthRepoImpel())),
          BlocProvider(create: (context) => UploadPhotoCubit()),
          BlocProvider(create: (_) => LocationCubit()),
          BlocProvider(create: (_) => MapCubit()),
        ],
        child: ContainerWithBackgroundImage(
          image: isDark
              ? AppImages.backgroundDarkNoSpace
              : AppImages.backgroundLightNoSpace,
          child: SingleChildScrollView(
            child: BlocBuilder<AuthCubit, AuthStates>(
              builder: (context, state) {
                final cubit = context.read<AuthCubit>();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthAppbar(
                      onTap: () {
                        final locCubit = context.read<LocationCubit>();
                        final photoCubit = context.read<UploadPhotoCubit>();
                        photoCubit.clear();
                        cubit.clear();
                        locCubit.clear();
                        AppNavigator.pop();
                      },
                      title: "sign_up.your_information",
                    ),
                    SizedBox(height: AppSize.getHeight(24)),
                    const UploadPhotoCard(),
                    SizedBox(height: AppSize.getHeight(24)),
                    SignUpForm(
                      userTypeEnum: userTypeEnum,
                    ),
                    SizedBox(height: AppSize.getHeight(12)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    ));
  }
}
