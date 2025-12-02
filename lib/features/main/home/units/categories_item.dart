// part of '../components/home_user/view/home_user.dart';

// class CategoriesItems extends StatelessWidget {
//   const CategoriesItems({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // CustomActiveAndNotActiveInCategories(
//         //   svg: AppIcons.shops,
//         //   title: "homeShopOwner.shops",
//         //   borderColor: Colors.orangeAccent,
//         //   screen: AllShopsForUser(),
//         //   color: Colors.orangeAccent.shade400,
//         // ),
//         CustomActiveAndNotActiveInCategories(
//           svg: AppIcons.rent,
//           title: "homeShopOwner.rent",
//           borderColor: const Color(0xff74D778),
//           screen: AllProductsForSellingAndRent(
//               title: context.tr("homeShopOwner.rent"), isRent: true),
//           color: Colors.green,
//         ),
//         CustomActiveAndNotActiveInCategories(
//           svg: AppIcons.selling,
//           title: "homeShopOwner.selling",
//           borderColor: const Color(0xffEBFA6E),
//           screen: AllProductsForSellingAndRent(
//             title: context.tr("homeShopOwner.selling"),
//           ),
//           color: const Color(0xffd9e862),
//         ),
//         CustomActiveAndNotActiveInCategories(
//           svg: AppIcons.delegate,
//           title: "homeShopOwner.delegate",
//           borderColor: const Color(0xff53C9FF),
//           color: const Color(0xff57a5cb),
//           screen: BlocProvider(
//               create: (_) => MapStoresCubit(mapRepo: MapRepoImpel())
//                 ..changeSelected(value: MapFilter.delivery),
//               child: MapsView(showBack: true)),
//         ),
//       ],
//     );
//   }
// }
