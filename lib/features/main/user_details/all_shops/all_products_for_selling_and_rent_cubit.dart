import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/dio_helper.dart';
import '../../../../core/helper/app_toast.dart';
import '../../../../models/store_model.dart';
import '../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import 'selling_rent_product.dart';

part 'all_products_for_selling_and_rent_state.dart';

class AllProductsForSellingAndRentCubit
    extends Cubit<AllProductsForSellingAndRentState> {
  AllProductsForSellingAndRentCubit()
      : super(AllProductsForSellingAndRentState(
            requestState: RequestStateEnum.initial,
            stores: [],
            productForProductiveFamily: []));
  updateRent(bool isRent) {
    emit(state.copyWith(isRent: isRent));
  }

  Future<void> getAllStoresForUser({
    int? selectedCategoryId,
    int? subcategoryId,
    int? selectedCountryId,
    int? selectedCityId,
    String? search,
  }) async {
    try {
      emit(state.copyWith(requestState: RequestStateEnum.loading));

      // Query parameters build karna
      final queryParams = <String, dynamic>{
        'sale_type': state.isRent ? 'rent' : 'sell',
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (selectedCategoryId != null) {
        queryParams['category_id'] = selectedCategoryId.toString();
      }
      if (subcategoryId != null) {
        queryParams['subcategory_id'] = subcategoryId.toString();
      }
      if (selectedCityId != null) {
        queryParams['city_id'] = selectedCityId.toString();
      }
      if (selectedCountryId != null) {
        queryParams['country_id'] = selectedCountryId.toString();
      }

      // API call with all filters
      final response = await DioHelper.get(
        'user/products',
        parameter: queryParams,
      );

      if (isClosed) return;

      if (response.isSuccess) {
        final List<dynamic> dataList = response.data?['data'] ?? [];

        final List<SellingAndRentProduct> fetchedStores =
            dataList.map((e) => SellingAndRentProduct.fromJson(e)).toList();

        emit(state.copyWith(
          stores: fetchedStores,
          requestState: RequestStateEnum.done,
        ));
      } else {
        emit(state.copyWith(requestState: RequestStateEnum.error));
      }
    } catch (e) {
      if (isClosed) return;
      log("the error cause ${e.toString()}");
      AppToast.error(e.toString());
      emit(state.copyWith(requestState: RequestStateEnum.error));
    }
  }

  Future<void> getAllProductForProductiveFamily({
    int? selectedCategoryId,
    int? subcategoryId,
    int? selectedCountryId,
    int? selectedCityId,
    String? search,
    String? selltype,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      
      if (selltype != null && selltype.isNotEmpty) {
        queryParams['sale_type'] = selltype;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }
      if (selectedCategoryId != null) {
        queryParams['category_id'] = selectedCategoryId.toString();
      }
      if (subcategoryId != null) {
        queryParams['subcategory_id'] = subcategoryId.toString();
      }
      if (selectedCityId != null) {
        queryParams['city_id'] = selectedCityId.toString();
      }
      if (selectedCountryId != null) {
        queryParams['country_id'] = selectedCountryId.toString();
      }
      emit(state.copyWith(requestState: RequestStateEnum.loading));
      final response = await DioHelper.get('user/product-for-productive-family',
          parameter: queryParams);
      if (isClosed) return;
      if (response.isSuccess) {
        final List<SellingAndRentProduct> fetchedStores =
            List<SellingAndRentProduct>.from((response.data?['data'] ?? [])
                .map((e) => SellingAndRentProduct.fromJson(e)));
        emit(state.copyWith(stores: []));
        emit(state.copyWith(stores: fetchedStores));
        emit(state.copyWith(requestState: RequestStateEnum.done));
      }
    } catch (e) {
      if (isClosed) return;
      log("the error cause ${e.toString()}");
      AppToast.error(e.toString());

      emit(state.copyWith(requestState: RequestStateEnum.error));
    }
  }
}
