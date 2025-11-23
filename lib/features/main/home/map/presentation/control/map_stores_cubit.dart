import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/helper/app_navigator.dart';
import '../../../../../../core/helper/app_toast.dart';
import '../../../../../../models/user_model.dart';
import '../../../../../delivery_user_view/chat/data/model/contact_model.dart';
import '../../../../../delivery_user_view/chat/data/repo/chat_repo_impel.dart';
import '../../../../../delivery_user_view/home_delivery_user/data/enum/request_state_enum.dart';
import '../../../contact/presentation/controller/manager_chat_cubit.dart';
import '../../../contact/presentation/view/details_of_chat.dart';
import '../../data/model/map_store_model.dart';
import '../../data/repo/map_repo.dart';

part 'map_stores_state.dart';

class MapStoresCubit extends Cubit<MapStoresState> {
  final MapRepo mapRepo;
  MapStoresCubit({required this.mapRepo})
      : super(MapStoresState(
            listOfStores: [],
            requestState: RequestStateEnum.initial,
            markers: {},
            selected: MapFilter.shops,
            listOfRepresentative: []));
  _loadingDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.loading, markers: {}));
  }

  _doneGetDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.done));
  }

  _errorGetDataOfChat() {
    emit(state.copyWith(requestState: RequestStateEnum.error));
  }

  Future<void> getStoresList({String? text}) async {
    _loadingDataOfChat();

    final api = await mapRepo.getStores(text: text);
    api.fold(
      (failure) {
        print('failures:${failure.errMessage}');

        _errorGetDataOfChat();
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) async {
        _doneGetDataOfChat();
        print('async:${r.length}');
        List<MapStoresModel> tempListOfStores = r
            .where((store) =>
                store.location?.latitude != null &&
                store.location?.longitude != null)
            .toList();
        emit(state.copyWith(
          listOfStores: tempListOfStores,
        ));
        await _handlingTheMarkers();
      },
    );
  }

  Future<void> getRepresentativeList({String? text}) async {
    _loadingDataOfChat();

    final api = await mapRepo.getRepresentativeForMap(text: text);
    api.fold(
      (failure) {
        print('failure:${failure.errMessage}');

        _errorGetDataOfChat();
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) async {
        _doneGetDataOfChat();
        print('async:${r.length}');
        List<UserModel> tempListOfRepresentative = r
            .where((store) => store.latitude != null && store.longitude != null)
            .toList();
        print('tempListOfRepresentative:${tempListOfRepresentative.length}');

        emit(state.copyWith(
          listOfRepresentative: tempListOfRepresentative,
        ));
        await _handlingTheMarkersFromRepresentative();
      },
    );
  }

  _handlingTheMarkers() {
    Set<Marker> markers = <Marker>{};
    for (var ele in state.listOfStores) {
      if (ele.location?.latitude != null && ele.location?.longitude != null) {
        final latLng = LatLng(
          double.parse("${ele.location?.latitude}"),
          double.parse("${ele.location?.longitude}"),
        );
        markers.add(
          Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(32.7), // Orange color
            markerId: MarkerId(latLng.toString()),
            position: latLng,
          ),
        );
      }
    }
    emit(state.copyWith(markers: markers));
  }

  _handlingTheMarkersFromRepresentative() {
    Set<Marker> markers = <Marker>{};
    for (var ele in state.listOfRepresentative) {
      if (ele.latitude != null && ele.longitude != null) {
        final latLng = LatLng(
          double.parse("${ele.latitude}"),
          double.parse("${ele.longitude}"),
        );
        markers.add(
          Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(201.43),
            markerId: MarkerId(latLng.toString()),
            position: latLng,
          ),
        );
      }
    }
    emit(state.copyWith(markers: markers));
  }

  changeSelected({required MapFilter? value}) {
    emit(state.copyWith(selected: value));
    if (value == MapFilter.shops) {
      getStoresList();
    } else if (value == MapFilter.delivery) {
      getRepresentativeList();
    }
  }

  changeSelectedShop({required int? value}) {
    emit(state.copyWith(selectedShop: value));
  }

  Future<void> addRepresentative(
      {UserModel? representativeUser, required BuildContext context}) async {
    final api =
        await mapRepo.addOder(representativeId: representativeUser?.id ?? 0);
    api.fold(
      (failure) {
        _errorGetDataOfChat();
        if (failure.error.isEmpty) {
          String errMsg = "failure.unexpected_error".tr();
          AppToast.error(errMsg);
        } else if (failure.error[0].field == 'general') {
          AppToast.error(failure.error[0].message ?? "");
        }
      },
      (r) async {
        AppNavigator.push(BlocProvider(
          create: (_) => ManagerChatCubit(chatRepo: ChatRepoImpel())
            ..saveSelectedContact(ContactFromListModel(
                id: r, contactName: representativeUser?.name)),
          child: DetailsOfChat(),
        ));
      },
    );
  }
}
