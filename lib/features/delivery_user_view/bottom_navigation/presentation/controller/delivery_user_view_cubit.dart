import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../core/cache/cache_helper.dart';
import '../../../../../core/main_keys.dart';
import '../../../home_delivery_user/data/model/order_state_model.dart';
import '../widget/alert_of_new_order.dart';

part 'delivery_user_view_state.dart';

class DeliveryUserViewCubit extends Cubit<DeliveryUserViewInitial> {
  DeliveryUserViewCubit({required BuildContext context})
      : super(DeliveryUserViewInitial(context: context)) {
    _connectTheSocket();
  }
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  Future<void> _connectTheSocket() async {
    print('_connectTheSocket');

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
      //       "Accept": "application/json",
      //       "Content-Type": "application/json",
      //     },
      //     body: jsonEncode({
      //       "socket_id": socketId,
      //       "channel_name": channelName,
      //     }),
      //   );
      //   log("response.statusCode : ${response.statusCode}");
      //   if (response.statusCode == 200) {
      //     print("Auth success: ${response.body}");
      //     return jsonDecode(response.body); // MUST RETURN MAP
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
      onConnectionStateChange: onConnectionStateChange,
    );

    await pusher.connect();

    await pusher.subscribe(
      channelName: "private-representative.${CachHelper.userId ?? 10}",
    );
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
    log("Me1: $me");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection3: $currentState :representative.${CachHelper.userId ?? 10}");
  }

  void onEvent(PusherEvent event) {
    try {
      log('onEvent-channelName3:${event.channelName}');
      log('onEvent-eventName:${event.eventName}');
      log('onEvent-data:-${event.data.toString()}-');
      log('onEvent-userId:${event.userId}');
      if (event.eventName.contains("NewOrderEvent")) {
        final data = jsonDecode(event.data);
        print("Received message: $data");
        OrderStateModel orderStateModel = OrderStateModel.fromJson(
            json.decode(event.data.toString())['order']);
        emit(state.copyWith(orderData: orderStateModel));
        _showNewOrderAlert(state.context);
      }
    } catch (e) {
      log("Failed to parse event data: $e");
    }
  }

  void _showNewOrderAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertOfNewOrder(
          orderData: state.orderData ?? OrderStateModel(id: 11),
        );
      },
    );
  }
}
