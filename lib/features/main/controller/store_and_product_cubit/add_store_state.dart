part of 'add_store_cubit.dart';

abstract class StoreAndProductState {}

final class AddStoreInitial extends StoreAndProductState {}

final class AddStoreLoading extends StoreAndProductState {}

final class EditProductLoading extends StoreAndProductState {}

final class AddStoreSuccess extends StoreAndProductState {}

final class SearchLoaded extends StoreAndProductState {
  final List<dynamic> stores;
  SearchLoaded(this.stores);
}

final class AddStoreFailure extends StoreAndProductState {
  final String errMsg;
  AddStoreFailure(this.errMsg);
}

final class ChangeValue extends StoreAndProductState {}

class GetStoresSuccess extends StoreAndProductState {
  final List<StoreModel> stores;
  GetStoresSuccess(this.stores);
}

class GetStoresCommentsSuccess extends StoreAndProductState {
  final List<CommentsModel> comment;
  GetStoresCommentsSuccess(this.comment);
}

class GetProductsStoreCommentsSuccess extends StoreAndProductState {
  final List<CommentsModel> comment;
  GetProductsStoreCommentsSuccess(this.comment);
}

class StoreAndProductInitial extends StoreAndProductState {}

class FiltersUpdated extends StoreAndProductState {}

// 🔹 category-only states
class CategoriesLoading extends StoreAndProductState {}

class CategoriesLoaded extends StoreAndProductState {}

class CategoriesFailure extends StoreAndProductState {}

// 🔹 discount card states (final merged clean version)
class DiscountCardInitial extends StoreAndProductState {}

class DiscountCardLoading extends StoreAndProductState {}

class DiscountCardSuccess extends StoreAndProductState {
  final List<DiscountCardModel> cards;
  DiscountCardSuccess(this.cards);
}

class DiscountCardError extends StoreAndProductState {
  final String message;
  DiscountCardError(this.message);
}
