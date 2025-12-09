import 'dart:developer';

import 'package:dalil_2020_app/core/dio_helper.dart';
import 'package:dalil_2020_app/models/details_of_shop_owner_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/end_points.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/helper/app_toast.dart';
import '../../../../models/details_of_productive_families_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getShopOwnerSummaryDetails() async {
    try {
      emit(HomeLoading());
      final response = await DioHelper.get(
        PROFILE_SUMMARY,
      );
      if (response.isSuccess) {
        final ProfileShopOwnerSummaryModel list =
            ProfileShopOwnerSummaryModel.fromJson(response.data?['data'] ?? {});
        emit(HomeSuccess(list));
      } else {
        ServerFailure.fromResponse(response);
        AppToast.error(response.msg);
        emit(HomeInitial());
      }
    } catch (e) {
      ServerFailure.fromCatchError(e);
      log(e.toString());
      emit(HomeInitial());
    }
  }

  Future<void> getProductiveDetails() async {
    try {
      emit(HomeLoading());
      final response = await DioHelper.get(
        PROFILE_PRODUCTIVE_SUMMARY,
      );
      if (response.isSuccess) {
        final ProfileProductiveFamiliesModel list =
            ProfileProductiveFamiliesModel.fromJson(
                response.data?['data'] ?? {});
        emit(HomeProductiveSuccess(list));
      } else {
        ServerFailure.fromResponse(response);
        log(response.msg);
        emit(HomeInitial());
      }
    } catch (e) {
      ServerFailure.fromCatchError(e);
      log(e.toString());
      emit(HomeInitial());
    }
  }
}
