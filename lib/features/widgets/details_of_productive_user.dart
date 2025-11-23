part of '../main/home/components/home_productve.dart';
class DetailsOfProductiveUser extends StatelessWidget {
  const DetailsOfProductiveUser({super.key,
    required this.successLoadUserData,
    required this.homeState, required this.onTap});
  final bool successLoadUserData;
  final dynamic  homeState;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                child: GestureDetector(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    AppSvg.menu,
                    colorFilter:ColorFilter.mode(AppColors.primaryProductive, BlendMode.srcIn) ,
                    fit: BoxFit.scaleDown,
                  ),
                )),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "navHome.hi".tr(),
                  style: kTextStyle14white.copyWith(
                      color: AppColors.whiteAndBlackColor
                  ),
                ),
                Text(
                  successLoadUserData ? homeState.list.profileName ?? '': CachHelper.userName ?? '',
                  style: kTextStyle16Orange.copyWith(color: AppColors.primaryProductive),
                ),
              ],
            ),
            const Spacer(),
            CustomUserProfileImage(
              url: successLoadUserData?homeState.list.profilePicture:CachHelper.image,
              color: AppColors.primaryProductive,),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          spacing: 4.w,
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DetailsOfUserInHome(
                borderRadius:CachHelper.lang == 'en'
                    ? const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                )
                    : const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
                icon: AppIcons.star,
                number:successLoadUserData?homeState.list.overallStoreRating.toString() : '0',
                label:"navHome.star",
                borderColor: AppColors.primaryProductive,
                style:TextStyle(color: AppColors.whiteAndBlackColor),
              ),
            ),
            Expanded(
              child: DetailsOfUserInHome(
                borderColor: AppColors.primaryProductive,
                style:TextStyle(color: AppColors.whiteAndBlackColor),
                borderRadius: BorderRadius.zero,
                icon: AppSvg.delivery,
                number:successLoadUserData?homeState.list.order.toString() : "0",
                label:"homeProductive.order",
              
              ),
            ),
            Expanded(
              child: DetailsOfUserInHome(
                borderColor: AppColors.primaryProductive,
                style:  TextStyle(color: AppColors.whiteAndBlackColor),
                borderRadius: BorderRadius.zero,
                icon: AppIcons.eyeOpen,
                number:successLoadUserData?homeState.list.totalViews.toString() : '0',
                label:"navHome.view",
              ),
            ),
            Expanded(
              child: DetailsOfUserInHome(
                borderColor: AppColors.primaryProductive,
                style:  TextStyle(color: AppColors.whiteAndBlackColor),
                borderRadius:CachHelper.lang == 'en'
                    ? const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                )
                    : const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
                icon:  AppIcons.box,
                number:successLoadUserData?homeState.list.totalProducts.toString() : '0',
                label:"navHome.product",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
