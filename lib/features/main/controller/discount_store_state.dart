import 'package:dalil_2020_app/models/discount_model.dart';
import 'package:equatable/equatable.dart';

abstract class DiscountCardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DiscountCardInitial extends DiscountCardState {}

class DiscountCardLoading extends DiscountCardState {}

class DiscountCardSuccess extends DiscountCardState {
  final List<DiscountCardModel> cards;
  DiscountCardSuccess(this.cards);

  @override
  List<Object?> get props => [cards];
}

class DiscountCardError extends DiscountCardState {
  final String message;
  DiscountCardError(this.message);

  @override
  List<Object?> get props => [message];
}
