import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../../core/main_keys.dart';
import '../control/map_of_home_cubit.dart';

class MapOfHome extends StatefulWidget {
  @override
  State<MapOfHome> createState() => _MapOfHomeState();
}

class _MapOfHomeState extends State<MapOfHome> {
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  GoogleMapController? gmapController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapOfHomeCubit, MapOfHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GoogleMap(
            onMapCreated: (GoogleMapController controller0) {
              controller.complete(controller0);
              gmapController = controller0;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(DEFULT_LAG, DEFULT_LNG),
              zoom: 5.0,
            ),
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            markers: state.markers,
            onTap: (position) {},
            onCameraMove: (position) {},
            gestureRecognizers: {
              Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer())
            },
          );
        });
  }
}
