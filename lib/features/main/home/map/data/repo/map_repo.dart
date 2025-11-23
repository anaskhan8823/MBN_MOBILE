import 'package:dartz/dartz.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../../models/user_model.dart';
import '../model/map_store_model.dart';

abstract class MapRepo {
  Future<Either<Failure, List<MapStoresModel>>> getStores({String? text});
  Future<Either<Failure, int>> addOder({required int representativeId});
  Future<Either<Failure, List<UserModel>>> getRepresentativeForMap(
      {String? text});
}
