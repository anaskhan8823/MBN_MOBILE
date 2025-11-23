import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';

abstract class OrderDetailsRepo {
  Future<Either<Failure, OrderStateModel>> getTheOrderDetails(int orderId);
  Future<Either<Failure, bool>> confirmOrder(int orderId);
  Future<Either<Failure, bool>> cancelOrder(int orderId);
}
