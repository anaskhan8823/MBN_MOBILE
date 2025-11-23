part of '../home/components/home_shop_owner.dart';

class DetailsOfShopOwnerUser extends StatelessWidget {
  const DetailsOfShopOwnerUser(
      {super.key,
      required this.successLoadUserData,
      required this.homeState,
      required this.onTap});
  final bool successLoadUserData;
  final dynamic homeState;
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
                fit: BoxFit.scaleDown,
              ),
            )),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "navHome.hi".tr(),
                  style: kTextStyle14white,
                ),
                Text(
                  successLoadUserData
                      ? homeState.list.profileName ?? ''
                      : CachHelper.userName ?? '',
                  style: kTextStyle16Orange,
                ),
              ],
            ),
            const Spacer(),
            const CustomUserProfileImage(),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DetailsOfUserInHome(
                borderRadius: CachHelper.lang == 'en'
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                icon: AppIcons.star,
                number: successLoadUserData
                    ? homeState.list.overallStoreRating.toString()
                    : '0',
                label: "navHome.star",
              ),
            ),
            Expanded(
              child: DetailsOfUserInHome(
                borderRadius: BorderRadius.zero,
                icon: AppSvg.shopSolid,
                number: successLoadUserData
                    ? homeState.list.totalStores.toString()
                    : '0',
                label: "navHome.shop",
              ),
            ),
            Expanded(
              child: DetailsOfUserInHome(
                borderRadius: BorderRadius.zero,
                icon: AppIcons.eyeOpen,
                number: successLoadUserData
                    ? homeState.list.totalViews.toString()
                    : '0',
                label: "navHome.view",
              ),
            ),
            Expanded(
              child: DetailsOfUserInHome(
                borderRadius: CachHelper.lang == 'en'
                    ? const BorderRadius.only(
                        topRight: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                      ),
                icon: AppIcons.box,
                number: successLoadUserData
                    ? homeState.list.totalProducts.toString()
                    : '0',
                label: "navHome.product",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
