import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../../../../core/helper/app_toast.dart';
import '../../../../map/data/model/map_store_model.dart';
import '../../../../map/data/repo/map_repo.dart';

part 'map_of_home_state.dart';

class MapOfHomeCubit extends Cubit<MapOfHomeState> {
  final MapRepo mapRepo;
  MapOfHomeCubit({required this.mapRepo})
      : super(MapOfHomeState(listOfStores: [], markers: {}));

  Future<void> getStoresList() async {
    final api = await mapRepo.getStores();
    api.fold(
      (failure) {
        print('failure:${failure.errMessage}');

        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) async {
        print('async:${r.length}');
        emit(state.copyWith(
          listOfStores: r,
        ));
        await _handlingTheMarkers();
      },
    );
  }

  _handlingTheMarkers() {
    Set<Marker> markers = <Marker>{};
    for (var ele in state.listOfStores) {
      final latLng = LatLng(
        double.parse("${ele.location?.latitude}"),
        double.parse("${ele.location?.longitude}"),
      );
      markers.add(
        Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue((46.00)),
          markerId: MarkerId(latLng.toString()),
          position: latLng,
        ),
      );
    }
    emit(state.copyWith(markers: markers));
  }
}
