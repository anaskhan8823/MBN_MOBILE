import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:quiver/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/helper/app_toast.dart';
import '../../../../../../core/main_keys.dart';
import '../../../../../../models/comments_model.dart';
import '../../../../../delivery_user_view/chat/data/model/contact_model.dart';
import '../../../../../delivery_user_view/chat/data/model/message_model.dart';
import '../../../../../delivery_user_view/chat/data/repo/chat_repo.dart';
import '../../../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../../../delivery_user_view/home_delivery_user/data/model/paginate_model.dart';

part 'manager_chat_state.dart';

class ManagerChatCubit extends Cubit<ManagerChatState> {
  final ChatRepo chatRepo;

  ManagerChatCubit({required this.chatRepo})
      : super(ManagerChatState(
            historyOfChat: [],
            requestState: RequestStateEnum.initial,
            tempHistoryOfChat: [],
            page: 0,
            historyOfMessages: []));

  _loadingDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.loading));
  }

  _doneGetDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.done));
  }

  _errorGetDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.error));
  }

  _updatePageNumber() {
    int page = state.page;
    page++;
    emit(state.copyWith(page: page));
  }

  Future<void> getHistoryOfContact(int? page) async {
    if (page != null) {
      _loadingDataOfChat();
      emit(state.copyWith(page: 0, historyOfChat: []));
    }
    if (state.page > (state.paginateData?.totalPages ?? 0)) {
      return;
    }
    _updatePageNumber();
    ();
    final api = await chatRepo.getAllContactChat();
    api.fold(
      (failure) {
        _errorGetDataOfChat();
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        _doneGetDataOfChat();
        emit(state.copyWith(
            historyOfChat: state.historyOfChat..addAll(r.items ?? []),
            tempHistoryOfChat: state.tempHistoryOfChat..addAll(r.items ?? []),
            paginateData: r.paginate));
      },
    );
  }

  Future<void> sendMessage({required String message}) async {
    if (isBlank(message)) return;
    chatRepo.sendMessage(state.selectedContact?.id ?? 0, message);

    List<MessageModel> myMessages = state.historyOfMessages;
    emit(state.copyWith(historyOfMessages: []));
    myMessages.add(MessageModel(
        content: message,
        user: User(
            id: CachHelper.userId,
            name: CachHelper.userName?.toString(),
            avatar: CachHelper.image?.toString())));
    emit(state.copyWith(historyOfMessages: myMessages));
  }

  void getContactFromSearch(String? text) {
    List<ContactFromListModel> historyOfChat = state.historyOfChat;
    if (isBlank(text) == true) {
      emit(state.copyWith(tempHistoryOfChat: historyOfChat));
    } else {
      List<ContactFromListModel> chatAfterFilter = historyOfChat
          .where((ele) =>
              ele.contactName
                  ?.toLowerCase()
                  .contains(text?.toLowerCase() ?? '') ??
              false)
          .toList();
      emit(state.copyWith(tempHistoryOfChat: chatAfterFilter));
    }
  }

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  saveSelectedContact(ContactFromListModel selectedContact) {
    emit(state.copyWith(selectedContact: selectedContact));
    _connectTheSocket();
    _getHistoryOfMessages();
  }

  _getHistoryOfMessages() async {
    final api = await chatRepo.getAllOldMessagesChat(
        chatId: state.selectedContact?.id ?? 0);
    api.fold(
      (failure) {
        _errorGetDataOfChat();
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) {
        _doneGetDataOfChat();
        emit(state.copyWith(
            historyOfMessages: (r.items ?? []).reversed.toList(),
            paginateData: r.paginate));
      },
    );
  }

  clearSelectedContact() async {
    emit(state.clearTheSelectedContact());
    await pusher.disconnect();
  }

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
        onConnectionStateChange: onConnectionStateChange);
    // log('logprivate-chat.${state.selectedContact?.id ?? 0}');
    await pusher.connect();
    await pusher.subscribe(
      channelName: "chat.${state.selectedContact?.id ?? 0}",
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
    log("Me3: $me");
  }

  void onDecryptionFailure(String event, String reason) {
    log("onDecryptionFailure: $event reason: $reason");
  }

  String? currentStateOfPusher;
  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    log("Connection1: $currentState :trip.passenger.");
    log("Connection: $currentState :chat.${state.selectedContact?.id}");
  }

  void onEvent(PusherEvent event) {
    log('onEvent');
    try {
      log('onEvent-channelName1:${event.channelName}');
      log('onEvent-eventName:${event.eventName}');
      log('onEvent-data:-${event.data.toString()}-');
      log('onEvent-userId:${event.userId}');
      if (event.eventName.contains("App\\Events\\MessageSent") ||
          event.eventName.contains("MessageSent") ||
          event.eventName.contains("message.sent") ||
          event.eventName.contains("App\\Events\\message.sent") ||
          event.eventName.contains("App\\Events\\messageSent") ||
          event.eventName.contains("new-message") ||
          event.eventName.contains("subscription_succeeded")) {
        final data = jsonDecode(event.data);
        print("Received message: $data");
        List<MessageModel> myMessages = state.historyOfMessages;
        myMessages.add(MessageModel.fromJson(
            json.decode(event.data.toString())['message']));
        emit(state.copyWith(historyOfMessages: []));
        emit(state.copyWith(historyOfMessages: myMessages));
      }
    } catch (e) {
      log("Failed to parse event data: $e");
    }
  }
}
