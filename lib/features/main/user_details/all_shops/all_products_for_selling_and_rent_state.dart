part of 'all_products_for_selling_and_rent_cubit.dart';

@immutable
class AllProductsForSellingAndRentState extends Equatable {
  final RequestStateEnum requestState;
  final List<SellingAndRentProduct> stores;
  final List<SellingAndRentProduct> productForProductiveFamily;
  final bool isRent;
  AllProductsForSellingAndRentState(
      {required this.stores,
      required this.requestState,
      this.isRent = true,
      required this.productForProductiveFamily});
  AllProductsForSellingAndRentState copyWith(
      {RequestStateEnum? requestState,
      List<SellingAndRentProduct>? stores,
      List<SellingAndRentProduct>? productForProductiveFamily,
      bool? isRent}) {
    return AllProductsForSellingAndRentState(
      requestState: requestState ?? this.requestState,
      stores: stores ?? this.stores,
      productForProductiveFamily:
          productForProductiveFamily ?? this.productForProductiveFamily,
      isRent: isRent ?? this.isRent,
    );
  }

  @override
  List<Object?> get props =>
      [productForProductiveFamily, requestState, stores, isRent];
}
