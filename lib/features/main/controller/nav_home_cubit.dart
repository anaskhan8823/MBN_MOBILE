import 'package:dalil_2020_app/constans.dart';
import 'package:dalil_2020_app/core/style/app_colors.dart';
import 'package:dalil_2020_app/features/main/add_product/view.dart';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:dalil_2020_app/features/main/home/components/add_in_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/data/repo/auth_repo_impel.dart';
import '../../delivery_user_view/chat/data/repo/chat_repo_impel.dart';
import '../../delivery_user_view/home_delivery_user/data/repo/orders_repo.dart';
import '../../delivery_user_view/home_delivery_user/data/repo/orders_repo_impel.dart';
import '../../delivery_user_view/home_delivery_user/presentation/controller/orders_cubit.dart';
import '../../delivery_user_view/home_delivery_user/presentation/view/home_delivery_user.dart';
import '../../delivery_user_view/my_orders_screen/my_orders.dart';
import '../driver_details/all_orders/view.dart';
import '../home/components/home_driver.dart';
import '../home/components/home_shop_owner.dart';
import '../home/contact/presentation/controller/manager_chat_cubit.dart';
import '../home/contact/presentation/view/chats.dart';
import '../home/map/data/repo/map_repo_impel.dart';
import '../home/map/presentation/control/map_stores_cubit.dart';
import '../productive_families_details/all_products/view.dart';
import '../shop_owner_details/add_store/nav_and_stepper_add_store.dart';
import '../home/components/home_user/view/home_user.dart';
import '../home/map/presentation/view/maps.dart';
import '../home/components/profile.dart';
import '../shop_owner_details/all_stores/view.dart';
import '../home/components/home_productve.dart';
import '../shop_owner_details/all_stores/view.dart';

class NavCubit extends Cubit<int> {
  NavCubit({int? index}) : super(index ?? 0);
  final tabsOfUser = <Widget>[
    HomeUser(),
    BlocProvider(
        create: (_) => MapStoresCubit(mapRepo: MapRepoImpel())..getStoresList(),
        child: MapsView()),
    const AddProduct(enterScreen: kUser, storeId: null),
    BlocProvider(
        create: (_) => ManagerChatCubit(chatRepo: ChatRepoImpel())
          ..getHistoryOfContact(null),
        child: ChatsView(
          colorOfAppBarTitle: AppColors.primaryProductive,
        )),
    const MyAccountPage(),
  ];
  final tabsOfDeliveryUser = <Widget>[
    BlocProvider(
        create: (_) =>
            OrdersCubit(orderRepo: OrderRepoImpel())..getOrdersOnHome(null),
        child: HomeDeliveryUserScreen()),
    BlocProvider(
        create: (_) =>
            OrdersCubit(orderRepo: OrderRepoImpel())..getOrders(null),
        child: MyOrders()),
    BlocProvider(
        create: (_) => ManagerChatCubit(chatRepo: ChatRepoImpel())
          ..getHistoryOfContact(null),
        child: ChatsView(
          colorOfAppBarTitle: AppColors.textLabelSelected,
        )),
    MyAccountPage(
      color: AppColors.textLabelSelected,
    ),
  ];
  final tabsOfShopOwner = <Widget>[
    HomeShopOwner(),
    BlocProvider(
        create: (context) => StoreAndProductCubit()..getAllStores(),
        child: AllStores(
          hideBackButton: true,
        )),
    const NavAddStore(),
    BlocProvider(
        create: (_) => ManagerChatCubit(chatRepo: ChatRepoImpel())
          ..getHistoryOfContact(null),
        child: ChatsView()),
    const MyAccountPage(),
  ];
  final tabsOfProductiveFamilies = <Widget>[
    HomeProductiveFamilies(),
    const AllProductsProductiveFamiliesView(
      hideBackButton: true,
    ),
    const AddProduct(
      enterScreen: kProductiveFamilies,
      storeId: null,
    ),
    BlocProvider(
        create: (_) => ManagerChatCubit(chatRepo: ChatRepoImpel())
          ..getHistoryOfContact(null),
        child: ChatsView(
          colorOfAppBarTitle: AppColors.primaryProductive,
        )),
    MyAccountPage(
      color: AppColors.primaryProductive,
    ),
  ];
  final tabsOfDriver = <Widget>[
    HomeDriver(),
    const AllOrdersView(),
    BlocProvider(
        create: (_) => ManagerChatCubit(chatRepo: ChatRepoImpel())
          ..getHistoryOfContact(null),
        child: ChatsView(
          colorOfAppBarTitle: AppColors.primaryDriver,
        )),
    MyAccountPage(
      color: AppColors.primaryDriver,
    ),
  ];

  void changePage(int index) {
    emit(index);
  }

  static changeColor(int index, int currentIndex) {
    return index == currentIndex
        ? AppColors.primary
        : AppColors.navBarTextColor;
  }

  static changeColorForProductive(int index, int currentIndex) {
    return index == currentIndex
        ? AppColors.primaryProductive
        : AppColors.navBarTextColor;
  }

  static changeColorForDriver(int index, int currentIndex) {
    return index == currentIndex
        ? AppColors.primaryDriver
        : AppColors.navBarTextColor;
  }
}
