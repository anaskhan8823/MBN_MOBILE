// import 'dart:convert';
// import 'dart:developer';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:flutter/foundation.dart';

// class PusherManager {
//   PusherManager._privateConstructor();
//   static final PusherManager instance = PusherManager._privateConstructor();

//   final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();
//   bool _isConnected = false;

//   Future<void> init({
//     required String apiKey,
//     required String cluster,
//     bool logToConsole = true,
//     Function(String message, int? code, dynamic e)? onError,
//     Function(String channelName, dynamic data)? onSubscriptionSucceeded,
//     Function(PusherEvent event)? onEvent,
//     Function(String message, dynamic e)? onSubscriptionError,
//     Function(String event, String reason)? onDecryptionFailure,
//     Function(dynamic current, dynamic previous)? onConnectionStateChange,
//   }) async {
//     if (_isConnected) return;

//     await _pusher.init(
//       apiKey: apiKey,
//       cluster: cluster,
//       logToConsole: logToConsole,
//       onError: onError,
//       onSubscriptionSucceeded: onSubscriptionSucceeded,
//       onEvent: onEvent,
//       onSubscriptionError: onSubscriptionError,
//       onDecryptionFailure: onDecryptionFailure,
//       onConnectionStateChange: onConnectionStateChange,
//     );

//     await _pusher.connect();
//     _isConnected = true;
//     log("Pusher initialized and connected");
//   }

//   Future<void> subscribe(String channelName) async {
//     if (!_isConnected) {
//       log("Pusher not connected yet, cannot subscribe to $channelName");
//       return;
//     }
//     await _pusher.subscribe(channelName: channelName);
//     log("Subscribed to $channelName");
//   }

//   Future<void> unsubscribe(String channelName) async {
//     await _pusher.unsubscribe(channelName: channelName);
//     log("Unsubscribed from $channelName");
//   }

//   Future<void> disconnect() async {
//     if (_isConnected) {
//       await _pusher.disconnect();
//       _isConnected = false;
//       log("Pusher disconnected");
//     }
//   }

//   PusherChannelsFlutter get instancePusher => _pusher;
// }
