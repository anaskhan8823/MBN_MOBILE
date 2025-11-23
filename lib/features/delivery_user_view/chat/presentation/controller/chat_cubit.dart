import 'dart:developer';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dalil_2020_app/models/comments_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/helper/app_toast.dart';
import '../../../../../core/main_keys.dart';
import '../../../home_delivery_user/data/enum/request_state_enum.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';
import '../../data/model/message_model.dart';
import '../../data/repo/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatInitial> {
  final ChatRepo chatRepo;
  ChatCubit({required this.chatRepo, required OrderStateModel orderData})
      : super(ChatInitial(
            requestState: RequestStateEnum.initial,
            buttonState: RequestStateEnum.initial,
            messages: [],
            orderData: orderData)) {
    _connectTheSocket();
  }

  Future<void> sendMessage({required String message}) async {
    chatRepo.sendMessage(state.orderData.chat?.id ?? 0, message);

    List<MessageModel> myMessages = state.messages;
    // emit(state.copyWith(messages: []));
    myMessages.add(MessageModel(
        content: message,
        user: User(
            id: CachHelper.userId,
            name: CachHelper.userName?.toString(),
            avatar: CachHelper.image?.toString())));
    emit(state.copyWith(messages: myMessages));
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

  Future<bool?> acceptOrder() async {
    _loadingButton();
    final api = await chatRepo.confirmOrder(state.orderData.id ?? 0);
    api.fold(
      (failure) {
        emit(state.copyWith(buttonState: RequestStateEnum.initial));

        return false;
      },
      (r) {
        return true;
      },
    );
    return null;
  }

  Future<bool?> cancelOrder() async {
    _loadingButton();
    final api = await chatRepo.cancelOrder(state.orderData.id ?? 0);
    api.fold(
      (failure) {
        emit(state.copyWith(buttonState: RequestStateEnum.initial));

        return false;
      },
      (r) {
        return true;
      },
    );
    return null;
  }

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  Future<void> _connectTheSocket() async {
    await pusher.init(
        apiKey: '9d3f16b826ab38a5f40c',
        cluster: API_CLUSTER,
        // authEndpoint: "https://filterr.net/broadcasting/auth",
        // onAuthorizer: (channelName, socketId, options) async {
        //   final token = CachHelper.token; // your login token

        //   final response = await http.post(
        //     Uri.parse("https://filterr.net/broadcasting/auth"),
        //     headers: {
        //       "Authorization": "Bearer $token",
        //       "Content-Type": "application/json",
        //     },
        //     body: jsonEncode({
        //       "socket_id": socketId,
        //       "channel_name": channelName,
        //     }),
        //   );

        //   if (response.statusCode == 200) {
        //     print("Auth success: ${response.body}");
        //     return response.body; // VERY IMPORTANT
        //   } else {
        //     print("Auth ERROR: ${response.body}");
        //     throw Exception("Auth failed");
        //   }
        // },
        onError: onErrorSocket,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onDecryptionFailure: onDecryptionFailure,
        onConnectionStateChange: onConnectionStateChange);
    await pusher.connect();
    await pusher.subscribe(
        channelName: 'chat.${state.orderData.chat?.id ?? 0}');
  }

  void onErrorSocket(String message, int? code, dynamic e) {
    log("onError: $message code: $code exception: $e");
  }

  void onSubscriptionError(String message, dynamic e) {
    log("onSubscriptionError: $message Exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    log("onSubscriptionSucceeded: $channelName data: $data");
    final me = pusher.getChannel(channelName)?.me;
    log("Me2: $me");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  String? currentStateOfPusher;
  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    // log("Connection: $currentState :trip.passenger.");
    log("Connection2: $currentState :chat.${state.orderData.chat?.id}");
  }

  void onEvent(PusherEvent event) {
    try {
      log('onEvent-channelName2:${event.channelName}');
      log('onEvent-eventName:${event.eventName}');
      log('onEvent-data:-${event.data}-');

      // Any message event
      if (event.eventName.contains("MessageSent")) {
        final data = json.decode(event.data);
        final List<MessageModel> updated = List.from(state.messages);

        updated.add(MessageModel.fromJson(data['message']));

        emit(state.copyWith(messages: updated)); // Live update
      }
    } catch (e) {
      log("Failed to parse event data: $e");
    }
  }
}
