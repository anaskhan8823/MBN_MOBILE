import 'package:bloc/bloc.dart';
import 'package:dalil_2020_app/features/delivery_user_view/home_delivery_user/data/enum/order_state_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/helper/app_toast.dart';
import '../../../home_delivery_user/data/enum/request_state_enum.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';
import '../../data/repo/order_details_repo.dart';

part 'order_details_state.dart';

class OrdersDetailsCubit extends Cubit<OrderDetailsInitial> {
  final OrderDetailsRepo orderDetailsRepo;
  OrdersDetailsCubit(
      {required this.orderDetailsRepo, required OrderStateModel orderData})
      : super(OrderDetailsInitial(
            requestState: RequestStateEnum.initial,
            buttonState: RequestStateEnum.initial,
            orderData: orderData));

  _loadingOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.loading));
  }

  _loadingButton() {
    emit(state.copyWith(buttonState: RequestStateEnum.loading));
  }

  _doneOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.done));
  }

  _errorOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.error));
  }

  Future<void> getOrderDetails() async {
    _loadingOrders();
    final api =
        await orderDetailsRepo.getTheOrderDetails(state.orderData.id ?? 0);
    api.fold(
      (failure) {
        _errorOrders();
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        _doneOrders();
        emit(state.copyWith(orderData: r));
      },
    );
  }

  Future<bool?> acceptOrder() async {
    emit(state.copyWith(buttonState: RequestStateEnum.loading));
    final api = await orderDetailsRepo.confirmOrder(state.orderData.id ?? 0);

    bool? result;
    api.fold(
      (failure) {
        emit(state.copyWith(buttonState: RequestStateEnum.initial));
        result = false;
      },
      (r) {
        // Update the order status locally
        final updatedOrder =
            state.orderData.copyWith(status: OrderStateEnum.confirmed.key);
        emit(state.copyWith(
            orderData: updatedOrder, buttonState: RequestStateEnum.initial));
        result = true;
      },
    );

    return result;
  }

  Future<bool?> cancelOrder() async {
    emit(state.copyWith(buttonState: RequestStateEnum.loading));
    final api = await orderDetailsRepo.cancelOrder(state.orderData.id ?? 0);

    bool? result;
    api.fold(
      (failure) {
        emit(state.copyWith(buttonState: RequestStateEnum.initial));
        result = false;
      },
      (r) {
        // Update the order status locally
        final updatedOrder =
            state.orderData.copyWith(status: OrderStateEnum.canceled.key);
        emit(state.copyWith(
            orderData: updatedOrder, buttonState: RequestStateEnum.initial));
        result = true;
      },
    );

    return result;
  }
}
