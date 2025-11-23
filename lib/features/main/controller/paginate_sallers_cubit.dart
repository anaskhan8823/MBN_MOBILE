import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/dio_helper.dart';
import '../../../core/end_points.dart';
import '../../../core/helper/app_toast.dart';
import '../../../models/store_model.dart';
import '../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../delivery_user_view/home_delivery_user/data/model/paginate_model.dart';

part 'paginate_sallers_state.dart';

class PaginateSallersCubit extends Cubit<PaginateStoreState> {
  PaginateSallersCubit()
      : super(PaginateStoreState(
          storesData: [],
          page: 0,
          requestState: RequestStateEnum.initial,
        ));

  _loadingOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.loading));
  }

  _doneOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.done));
  }

  _errorOrders() {
    emit(state.copyWith(requestState: RequestStateEnum.initial));
  }

  _updatePageNumber() {
    int page = state.page;
    page++;
    emit(state.copyWith(page: page));
  }

  Future<void> getOrders(int? page) async {
    try {
      if (page != null) {
        _loadingOrders();
        emit(state.copyWith(page: 0, storesData: []));
      }
      if (state.page > (state.paginateData?.totalPages ?? 0)) {
        return;
      }
      _updatePageNumber();
      // final api = await orderRepo.getTheOrders(state.selectedState);
      final response = await DioHelper.get(ALL_STORES);
      if (isClosed) return;
      if (response.isSuccess) {
        final List<StoreModel> fetchedStores = List<StoreModel>.from(
            (response.data?['data']['items'] ?? [])
                .map((e) => StoreModel.fromJson(e)));
        final PaginateModel paginateData =
            PaginateModel.fromJson(response.data?['data']['paginate']);
        _doneOrders();
        emit(state.copyWith(
            storesData: state.storesData..addAll(fetchedStores),
            paginateData: paginateData));
      }
    } catch (e) {
      if (isClosed) return;
      _errorOrders();
      AppToast.error("the error cause ${e.toString()}");
    }
  }
}
