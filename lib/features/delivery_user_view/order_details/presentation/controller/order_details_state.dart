part of 'order_details_cubit.dart';

@immutable
class OrderDetailsInitial extends Equatable {
  final RequestStateEnum requestState;
  final RequestStateEnum buttonState;
  final OrderStateModel orderData;

  OrderDetailsInitial(
      {required this.requestState,
      required this.orderData,
      required this.buttonState});

  OrderDetailsInitial copyWith(
      {RequestStateEnum? requestState,
      RequestStateEnum? buttonState,
      OrderStateModel? orderData}) {
    return OrderDetailsInitial(
      requestState: requestState ?? this.requestState,
      orderData: orderData ?? this.orderData,
      buttonState: buttonState ?? this.buttonState,
    );
  }

  @override
  List<Object?> get props => [requestState, orderData, buttonState];
}
