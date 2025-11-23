part of 'paginate_sallers_cubit.dart';

@immutable
class PaginateStoreState extends Equatable {
  final PaginateModel? paginateData;
  final List<StoreModel> storesData;
  final int page;
  final RequestStateEnum requestState;

  PaginateStoreState(
      {this.paginateData,
      required this.storesData,
      required this.page,
      required this.requestState});
  PaginateStoreState copyWith(
      {int? page,
      RequestStateEnum? requestState,
      PaginateModel? paginateData,
      List<StoreModel>? storesData}) {
    return PaginateStoreState(
      page: page ?? this.page,
      requestState: requestState ?? this.requestState,
      paginateData: paginateData ?? this.paginateData,
      storesData: storesData ?? this.storesData,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [requestState, page, paginateData, storesData];
}
