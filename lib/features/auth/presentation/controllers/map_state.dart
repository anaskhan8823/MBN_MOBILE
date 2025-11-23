part of 'map_cubit.dart';

class MapState extends Equatable {
  final LatLng? location;

  MapState({this.location});
  MapState copyWith({LatLng? location}) {
    return MapState(location: location ?? this.location);
  }

  @override
  List<Object?> get props => [location];
}
