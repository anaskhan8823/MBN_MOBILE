part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class GetProductsSuccess extends ProductState {
  final List<ProductModel> product;
  GetProductsSuccess(this.product);
}

class GetProductsCommentsSuccess extends ProductState {
  final List<CommentsModel> comment;
  GetProductsCommentsSuccess(this.comment);
}
