part of 'chat_cubit.dart';

@immutable
class ChatInitial extends Equatable {
  final RequestStateEnum requestState;
  final RequestStateEnum buttonState;
  final OrderStateModel orderData;
  final List<MessageModel> messages;

  ChatInitial(
      {required this.requestState,
      required this.orderData,
      required this.messages,
      required this.buttonState});

  ChatInitial copyWith(
      {RequestStateEnum? requestState,
      RequestStateEnum? buttonState,
      List<MessageModel>? messages,
      OrderStateModel? orderData}) {
    return ChatInitial(
      requestState: requestState ?? this.requestState,
      orderData: orderData ?? this.orderData,
      messages: messages ?? this.messages,
      buttonState: buttonState ?? this.buttonState,
    );
  }

  @override
  List<Object?> get props => [messages, requestState, orderData, buttonState];
}
