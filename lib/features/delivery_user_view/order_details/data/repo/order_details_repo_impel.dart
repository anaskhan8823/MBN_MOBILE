import 'package:dartz/dartz.dart';

import '../../../../../core/dio_helper.dart';
import '../../../../../core/end_points.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/helper/app_toast.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';
import 'order_details_repo.dart';

class OrderDetailsRepoImpel implements OrderDetailsRepo {
  @override
  Future<Either<Failure, OrderStateModel>> getTheOrderDetails(
      int orderId) async {
    try {
      final response = await DioHelper.get(
        "$ORDER_DETAILS/$orderId",
      );
      if (response.isSuccess) {
        return right(OrderStateModel.fromJson(response.data['data']));
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(int orderId) async {
    try {
      final response = await DioHelper.put(
        "$CANCEL_ORDER/$orderId",
      );
      if (response.isSuccess) {
        return right(true);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, bool>> confirmOrder(int orderId) async {
    try {
      final response = await DioHelper.put("$CONFIRM_ORDER/$orderId");

      print('🐛 confirmOrder response: ${response.data}');

      if (response.isSuccess) {
        // Safely read message string
        final message = response.data?['data']?.toString() ??
            'Order confirmed successfully!';
        AppToast.success(message);
        return right(true);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(failure.errMessage);
      return left(failure);
    }
  }
}
