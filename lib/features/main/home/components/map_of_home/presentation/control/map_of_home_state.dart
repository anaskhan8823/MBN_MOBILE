part of 'map_of_home_cubit.dart';

@immutable
class MapOfHomeState extends Equatable {
  final List<MapStoresModel> listOfStores;
  final Set<Marker> markers;

  MapOfHomeState({
    required this.markers,
    required this.listOfStores,
  });
  MapOfHomeState copyWith(
      {List<MapStoresModel>? listOfStores, Set<Marker>? markers}) {
    return MapOfHomeState(
      listOfStores: listOfStores ?? this.listOfStores,
      markers: markers ?? this.markers,
    );
  }

  @override
  List<Object?> get props => [listOfStores, markers];
}
