import 'package:dalil_2020_app/core/shared/widgets/custom_svg.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/text_style.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../user/controllers/my_account_cubit.dart';
class BuildSwitchMenuItem extends StatelessWidget {
  const BuildSwitchMenuItem({super.key, required this.icon, required this.title,required this.color});
  final  String icon;
  final  String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    bool isDark=AppColors.isDark();
    return BlocBuilder<MyAccountCubit,MyAccountState>(
      builder:(context, state) {
        final cubit =context.read<MyAccountCubit>();
       return Padding(
            padding: const EdgeInsets.only(top: 13,left: 13,right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomSvg(svg: icon,color: color,),
                    const SizedBox(width: 12),
                    Text(title.tr(),
                        style: kTextStyle16white.copyWith(
                            color: AppColors.whiteAndBlackColor,
                            fontSize: 15, fontWeight: FontWeight.w500)),],
                ),
                GestureDetector(
                    onTap: ()async {
                      cubit.isSwitchSwitched();
                     context.read<ThemeCubit>().changeThemeMode();
                    context.read<ThemeCubit>().restartApplication();
                    },
                    child: AnimatedContainer(
                      duration:const Duration(milliseconds: 300),
                      width: 62,
                      height: 28,
                      decoration: BoxDecoration(
                        color: cubit.switchValue&&!isDark?Colors.white:const Color(0xFF4D2A00),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color, width: 2),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left:cubit.switchValue&&!isDark? 0:34,
                            top: 2,
                            bottom: 2,
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ));
      }
    );
  }
}
