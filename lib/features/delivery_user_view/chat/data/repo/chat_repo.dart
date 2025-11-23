import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';
import '../model/chat_with_paginate_model.dart';
import '../model/contact_with_paginate_model.dart';

abstract class ChatRepo {
  Future<Either<Failure, bool>> confirmOrder(int orderId);
  Future<Either<Failure, bool>> cancelOrder(int orderId);
  Future<Either<Failure, bool>> sendMessage(int chatId, String message);
  Future<Either<Failure, ContactWithPaginateModel>> getAllContactChat();
  Future<Either<Failure, ChatWithPaginateModel>> getAllOldMessagesChat(
      {required int chatId});
}
