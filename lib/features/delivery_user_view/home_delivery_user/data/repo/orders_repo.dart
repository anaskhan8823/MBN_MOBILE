import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../enum/order_state_enum.dart';
import '../model/order_state_model.dart';
import '../model/order_with_paginate_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, OrderWithPaginateModel>> getTheOrders(
      OrderStateEnum orderState);
}
