part of 'map_stores_cubit.dart';

enum MapFilter { shops, delivery }

extension TypeExtensionOfMapFilter on MapFilter {
  String text() {
    switch (this) {
      case MapFilter.shops:
        return tr('deliveryUserView.Shops');
      case MapFilter.delivery:
        return tr('deliveryUserView.Delivery');
    }
  }
}

@immutable
class MapStoresState extends Equatable {
  final List<MapStoresModel> listOfStores;
  final List<UserModel> listOfRepresentative;
  final RequestStateEnum requestState;
  final Set<Marker> markers;
  final MapFilter selected;
  final int? selectedShop;

  MapStoresState(
      {required this.markers,
      required this.listOfStores,
      required this.listOfRepresentative,
      required this.selected,
      this.selectedShop,
      required this.requestState});
  MapStoresState copyWith(
      {RequestStateEnum? requestState,
      List<MapStoresModel>? listOfStores,
      List<UserModel>? listOfRepresentative,
      MapFilter? selected,
      int? selectedShop,
      Set<Marker>? markers}) {
    return MapStoresState(
      requestState: requestState ?? this.requestState,
      selected: selected ?? this.selected,
      listOfRepresentative: listOfRepresentative ?? this.listOfRepresentative,
      selectedShop: selectedShop ?? this.selectedShop,
      listOfStores: listOfStores ?? this.listOfStores,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props => [
        selectedShop,
        selected,
        listOfRepresentative,
        listOfStores,
        requestState,
        markers
      ];
}
