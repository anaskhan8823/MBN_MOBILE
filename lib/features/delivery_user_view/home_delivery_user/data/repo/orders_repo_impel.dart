import 'package:dartz/dartz.dart';

import '../../../../../core/dio_helper.dart';
import '../../../../../core/end_points.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/helper/app_toast.dart';
import '../enum/order_state_enum.dart';
import '../model/order_state_model.dart';
import '../model/order_with_paginate_model.dart';
import 'orders_repo.dart';

class OrderRepoImpel implements OrderRepo {
  @override
  Future<Either<Failure, OrderWithPaginateModel>> getTheOrders(
      OrderStateEnum orderState) async {
    try {
      final response = await DioHelper.get(
        MY_ORDERS,
        parameter: {'status': orderState.key},
      );
      if (response.isSuccess) {
        return right(OrderWithPaginateModel.fromJson(response.data['data']));
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }
}
