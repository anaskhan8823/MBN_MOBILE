part of 'delivery_user_view_cubit.dart';

@immutable
class DeliveryUserViewInitial extends Equatable {
  final BuildContext context;
  final OrderStateModel? orderData;

  DeliveryUserViewInitial({required this.context, this.orderData});
  DeliveryUserViewInitial copyWith(
      {BuildContext? context, OrderStateModel? orderData}) {
    return DeliveryUserViewInitial(
        orderData: orderData ?? this.orderData,
        context: context ?? this.context);
  }

  @override
  List<Object?> get props => [context, orderData];
}
