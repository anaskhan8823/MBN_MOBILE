enum OrderStateEnum { pending, confirmed, canceled }

extension OrderStateEnumExtension on OrderStateEnum {
  String get key {
    switch (this) {
      case OrderStateEnum.pending:
        return "pending";
      case OrderStateEnum.confirmed:
        return "confirmed";
      case OrderStateEnum.canceled:
        return "canceled";
    }
  }
}
