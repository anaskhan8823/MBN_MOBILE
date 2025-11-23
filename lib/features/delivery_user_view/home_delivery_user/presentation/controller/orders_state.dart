part of 'orders_cubit.dart';

@immutable
class OrdersInitial extends Equatable {
  final OrderStateEnum selectedState;
  final RequestStateEnum requestState;
  final PaginateModel? paginateData;
  final PaginateModel? paginateDataOnHome;
  final List<OrderStateModel> ordersData;
  final List<OrderStateModel> ordersDataOnHome;
  final int page;

  OrdersInitial(
      {required this.selectedState,
      required this.requestState,
      required this.page,
      required this.ordersDataOnHome,
      this.paginateDataOnHome,
      this.paginateData,
      required this.ordersData});

  OrdersInitial copyWith({
    OrderStateEnum? selectedState,
    RequestStateEnum? requestState,
    int? page,
    PaginateModel? paginateData,
    PaginateModel? paginateDataOnHome,
    List<OrderStateModel>? ordersData,
    List<OrderStateModel>? ordersDataOnHome,
  }) {
    return OrdersInitial(
      selectedState: selectedState ?? this.selectedState,
      ordersDataOnHome: ordersDataOnHome ?? this.ordersDataOnHome,
      paginateDataOnHome: paginateDataOnHome ?? this.paginateDataOnHome,
      page: page ?? this.page,
      requestState: requestState ?? this.requestState,
      paginateData: paginateData ?? this.paginateData,
      ordersData: ordersData ?? this.ordersData,
    );
  }

  @override
  List<Object?> get props => [
        paginateData,
        page,
        selectedState,
        ordersDataOnHome,
        paginateDataOnHome,
        requestState,
        ordersData
      ];
}
