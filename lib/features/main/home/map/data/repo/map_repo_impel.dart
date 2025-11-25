import 'package:dalil_2020_app/models/user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../../../core/dio_helper.dart';
import '../../../../../../core/end_points.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../../core/helper/app_toast.dart';
import '../model/map_store_model.dart';
import 'map_repo.dart';

class MapRepoImpel implements MapRepo {
  @override
  Future<Either<Failure, List<MapStoresModel>>> getStores(
      {String? text}) async {
    try {
      final response =
          await DioHelper.get(MAP_STORES, parameter: {'search': text});
      if (response.isSuccess) {
        final fetchedStores = List<MapStoresModel>.from(
            (response.data['data'] ?? [])
                .map((e) => MapStoresModel.fromJson(e)));
        print('fetchedStores:$fetchedStores');
        return right(fetchedStores);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getRepresentativeForMap(
      {String? text}) async {
    try {
      final response =
          await DioHelper.get(MAP_REPRESENTATIVE, parameter: {'search': text});
      if (response.isSuccess) {
        final fetchedStores = List<UserModel>.from(
            (response.data['data'] ?? []).map((e) => UserModel.fromJson(e)));
        print('fetchedStores:$fetchedStores');
        return right(fetchedStores);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }

  @override
  Future<Either<Failure, int>> addOder({required int representativeId}) async {
    try {
      final response = await DioHelper.send(ADD_ORDER,
          data: {'representative_id': representativeId});
      if (response.isSuccess) {
        print('fetchedStores:${(response.data['data']['chat']['id'] ?? [])}');
        return right(response.data['data']['chat']['id']);
      } else {
        return left(ServerFailure.fromResponse(response));
      }
    } catch (e) {
      final failure = ServerFailure.fromCatchError(e);
      AppToast.error(e.toString());
      return left(failure);
    }
  }
}
