import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/dio_helper.dart';
import '../../../../../../core/end_points.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/helper/app_toast.dart';
import '../../../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../map/data/model/map_store_model.dart';
import '../../../map/data/repo/map_repo.dart';

part 'home_user_state.dart';

class HomeUserCubit extends Cubit<HomeUserState> {
  HomeUserCubit()
      : super(HomeUserState(
            listOfStoresHighestRated: [],
            listOfStoresFeatured: [],
            listOfStoresMostVisited: [],
            requestState: RequestStateEnum.initial));

  updateIndexTap(int index) {
    emit(state.copyWith(indexTap: index));
    if (index == 0) {
      getStoresListMostVisited();
    } else if (index == 1) {
      getStoresListFeatured();
    } else if (index == 2) {
      getStoresListHighestRated();
    }
  }

  _loadingDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.loading));
  }

  _doneGetDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.done));
  }

  _errorGetDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.error));
  }

  Future<void> getStoresListHighestRated({String? text}) async {
    _loadingDataOfChat();
    try {
      final response =
          await DioHelper.get(MAP_STORES, parameter: {'highest_rated': true});
      if (response.isSuccess) {
        final fetchedStores = List<MapStoresModel>.from(
            (response.data['data'] ?? [])
                .map((e) => MapStoresModel.fromJson(e)));
        print('fetchedStores:$fetchedStores');
        _doneGetDataOfChat();
        emit(state.copyWith(
          listOfStoresHighestRated: fetchedStores,
        ));
      } else {
        _errorGetDataOfChat();
        AppToast.error(response.data.error?[0].message ?? "");
      }
    } catch (e) {
      _errorGetDataOfChat();
      AppToast.error(e.toString());
    }
  }

  Future<void> getStoresListFeatured({String? text}) async {
    _loadingDataOfChat();
    try {
      final response =
          await DioHelper.get(MAP_STORES, parameter: {'is_featured': true});
      if (response.isSuccess) {
        final fetchedStores = List<MapStoresModel>.from(
            (response.data['data'] ?? [])
                .map((e) => MapStoresModel.fromJson(e)));
        print('fetchedStores:$fetchedStores');
        _doneGetDataOfChat();
        emit(state.copyWith(
          listOfStoresFeatured: fetchedStores,
        ));
      } else {
        _errorGetDataOfChat();
        AppToast.error(response.data.error?[0].message ?? "");
      }
    } catch (e) {
      _errorGetDataOfChat();
      AppToast.error(e.toString());
    }
  }

  Future<void> getStoresListMostVisited({String? text}) async {
    _loadingDataOfChat();
    try {
      final response =
          await DioHelper.get(MAP_STORES, parameter: {'most_visited': true});
      if (response.isSuccess) {
        final fetchedStores = List<MapStoresModel>.from(
            (response.data['data'] ?? [])
                .map((e) => MapStoresModel.fromJson(e)));
        print('fetchedStores:$fetchedStores');
        _doneGetDataOfChat();
        emit(state.copyWith(
          listOfStoresMostVisited: fetchedStores,
        ));
      } else {
        _errorGetDataOfChat();
        AppToast.error(response.data.error?[0].message ?? "");
      }
    } catch (e) {
      _errorGetDataOfChat();
      AppToast.error(e.toString());
    }
  }
}
