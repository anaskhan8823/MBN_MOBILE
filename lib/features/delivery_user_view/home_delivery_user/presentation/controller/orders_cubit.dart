import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/helper/app_toast.dart';
import '../../data/enum/order_state_enum.dart';
import '../../data/enum/request_state_enum.dart';
import '../../data/model/order_state_model.dart';
import '../../data/model/paginate_model.dart';
import '../../data/repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersInitial> {
  final OrderRepo orderRepo;
  OrdersCubit({required this.orderRepo})
      : super(OrdersInitial(
            selectedState: OrderStateEnum.pending,
            requestState: RequestStateEnum.initial,
            page: 0,
            ordersData: [],
            ordersDataOnHome: []));
  submitNewState({required OrderStateEnum newState}) {
    emit(state.copyWith(selectedState: newState));
    getOrders(0);
  }

  _loadingOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.loading));
  }

  _doneOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.done));
  }

  _errorOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.error));
  }

  _updatePageNumber() {
    int page = state.page;
    page++;
    emit(state.copyWith(page: page));
  }

  Future<void> getOrders(int? page) async {
    if (page != null) {
      _loadingOrders();
      emit(state.copyWith(page: 0, ordersData: []));
    }
    if (state.page > (state.paginateData?.totalPages ?? 0)) {
      return;
    }
    _updatePageNumber();
    final api = await orderRepo.getTheOrders(state.selectedState);
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
        emit(state.copyWith(
            ordersData: state.ordersData..addAll(r.items ?? []),
            paginateData: r.paginate));
      },
    );
  }

  Future<void> getOrdersOnHome(int? page) async {
    if (page != null) {
      _loadingOrders();
      emit(state.copyWith(page: 0, ordersData: []));
    }
    if (state.page > (state.paginateData?.totalPages ?? 0)) {
      return;
    }
    _updatePageNumber();
    final api = await orderRepo.getTheOrders(state.selectedState);
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
        emit(state.copyWith(
            ordersDataOnHome: state.ordersData..addAll(r.items ?? []),
            paginateDataOnHome: r.paginate));
      },
    );
  }
}
