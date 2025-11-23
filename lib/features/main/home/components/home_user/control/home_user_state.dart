part of 'home_user_cubit.dart';

@immutable
class HomeUserState extends Equatable {
  final List<MapStoresModel> listOfStoresHighestRated;
  final List<MapStoresModel> listOfStoresFeatured;
  final List<MapStoresModel> listOfStoresMostVisited;
  final int indexTap;
  final RequestStateEnum requestState;

  HomeUserState(
      {required this.listOfStoresHighestRated,
      required this.listOfStoresFeatured,
      required this.requestState,
      this.indexTap = 0,
      required this.listOfStoresMostVisited});
  HomeUserState copyWith({
    List<MapStoresModel>? listOfStoresHighestRated,
    List<MapStoresModel>? listOfStoresFeatured,
    int? indexTap,
    RequestStateEnum? requestState,
    List<MapStoresModel>? listOfStoresMostVisited,
  }) {
    return HomeUserState(
      listOfStoresHighestRated:
          listOfStoresHighestRated ?? this.listOfStoresHighestRated,
      listOfStoresFeatured: listOfStoresFeatured ?? this.listOfStoresFeatured,
      indexTap: indexTap ?? this.indexTap,
      requestState: requestState ?? this.requestState,
      listOfStoresMostVisited:
          listOfStoresMostVisited ?? this.listOfStoresMostVisited,
    );
  }

  @override
  List<Object?> get props => [
        listOfStoresFeatured,
        listOfStoresHighestRated,
        indexTap,
        requestState,
        listOfStoresMostVisited
      ];
}
