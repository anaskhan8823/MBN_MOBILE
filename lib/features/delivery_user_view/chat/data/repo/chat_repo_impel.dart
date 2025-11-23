import 'package:dartz/dartz.dart';

import '../../../../../core/dio_helper.dart';
import '../../../../../core/end_points.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/helper/app_toast.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';
import '../model/chat_with_paginate_model.dart';
import '../model/contact_with_paginate_model.dart';
import 'chat_repo.dart';

class ChatRepoImpel implements ChatRepo {
  @override
  Future<Either<Failure, bool>> sendMessage(int chatId, String message) async {
    try {
      final response = await DioHelper.send(SEND_CHATS(chatId),
          data: {'type': 'text', 'content': message});
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
      final response = await DioHelper.put(
        "$CONFIRM_ORDER/$orderId",
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
  Future<Either<Failure, ContactWithPaginateModel>> getAllContactChat() async {
    try {
      final response = await DioHelper.get(
        CHATS_CHATS,
      );
      if (response.isSuccess) {
        return right(ContactWithPaginateModel.fromJson(response.data['data']));
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
  Future<Either<Failure, ChatWithPaginateModel>> getAllOldMessagesChat(
      {required int chatId}) async {
    try {
      final response = await DioHelper.get(
        "$CHATS_CHAT/$chatId",
      );
      if (response.isSuccess) {
        return right(
            ChatWithPaginateModel.fromJson(response.data['data']['messages']));
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
