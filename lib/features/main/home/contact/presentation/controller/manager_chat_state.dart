part of 'manager_chat_cubit.dart';


@immutable
class ManagerChatState extends Equatable {
  final List<ContactFromListModel> historyOfChat;
  final List<ContactFromListModel> tempHistoryOfChat;
  final PaginateModel? paginateData;
  final PaginateModel? paginateDataOfChat;
  final ContactFromListModel? selectedContact;
  final RequestStateEnum requestState;
  final int page;
  final List<MessageModel> historyOfMessages;

  ManagerChatState(
      {required this.historyOfChat,
      this.paginateData,
      this.selectedContact,
      this.paginateDataOfChat,
      required this.tempHistoryOfChat,
      required this.historyOfMessages,
      required this.page,
      required this.requestState});
  ManagerChatState copyWith({
    RequestStateEnum? requestState,
    List<ContactFromListModel>? historyOfChat,
    List<ContactFromListModel>? tempHistoryOfChat,
    List<MessageModel>? historyOfMessages,
    int? page,
    ContactFromListModel? selectedContact,
    PaginateModel? paginateData,
    PaginateModel? paginateDataOfChat,
  }) {
    return ManagerChatState(
      requestState: requestState ?? this.requestState,
      historyOfMessages: historyOfMessages ?? this.historyOfMessages,
      paginateDataOfChat: paginateDataOfChat ?? this.paginateDataOfChat,
      page: page ?? this.page,
      selectedContact: selectedContact ?? this.selectedContact,
      paginateData: paginateData ?? this.paginateData,
      tempHistoryOfChat: tempHistoryOfChat ?? this.tempHistoryOfChat,
      historyOfChat: historyOfChat ?? this.historyOfChat,
    );
  }

  ManagerChatState clearTheSelectedContact() {
    return ManagerChatState(
      requestState: requestState,
      page: page,
      historyOfMessages: [],
      paginateDataOfChat: null,
      selectedContact: null,
      paginateData: paginateData,
      tempHistoryOfChat: tempHistoryOfChat,
      historyOfChat: historyOfChat,
    );
  }

  @override
  List<Object?> get props => [
        paginateData,
        page,
        paginateDataOfChat,
        selectedContact,
        historyOfMessages,
        tempHistoryOfChat,
        historyOfChat,
        requestState
      ];
}
