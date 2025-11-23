// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../../../core/main_keys.dart';
// import '../controllers/map_cubit.dart';

// class MapWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MapWidget();
//   }
// }

// class _MapWidget extends State<MapWidget> {
//   Completer<GoogleMapController> controller = Completer<GoogleMapController>();
//   GoogleMapController? gmapController;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the current location when the widget is initialized
//     context.read<MapCubit>().getCurrentLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<MapCubit, MapState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return SizedBox(
//           height: 300.h,
//           width: MediaQuery.of(context).size.width,
//           child: GoogleMap(
//             myLocationButtonEnabled: false,
//             gestureRecognizers: {
//               Factory<OneSequenceGestureRecognizer>(
//                   () => EagerGestureRecognizer())
//             },
//             // zoomControlsEnabled: true,
//             // myLocationButtonEnabled: false,
//             mapType: MapType.normal,
//             initialCameraPosition: CameraPosition(
//               target: state.location ?? LatLng(DEFULT_LAG, DEFULT_LNG),
//               zoom: 5.0,
//             ),
//             markers: {
//               Marker(
//                 icon: BitmapDescriptor.defaultMarkerWithHue((46.00)),
//                 markerId: MarkerId(state.location.toString()),
//                 position: state.location ?? LatLng(DEFULT_LAG, DEFULT_LNG),
//               )
//             },
//             onCameraMove: (position) {
//               context.read<MapCubit>().updateLocation(position.target);
//             },
//             onMapCreated: (GoogleMapController controller0) {
//               setState(() {
//                 controller.complete(controller0);
//                 gmapController = controller0;
//               });
//             },
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:async';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // for search by place name

import '../../../../core/main_keys.dart';
import '../controllers/map_cubit.dart';
import 'dart:async';
import 'package:dalil_2020_app/features/main/controller/store_and_product_cubit/add_store_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../core/main_keys.dart';
import '../controllers/map_cubit.dart';

class MapWidget extends StatefulWidget {
  final TextEditingController? searchController;
  // final BuildContext? context;

  const MapWidget({
    Key? key,
    this.searchController,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  GoogleMapController? gmapController;
  MapType _mapType = MapType.normal;
  Marker? _searchedMarker;

  TextEditingController get _searchController =>
      widget.searchController!; // use passed controller

  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().getCurrentLocation();
  }

  /// Search location using the geocoding package
  // Future<void> _searchPlace(String query) async {
  //   if (query.isEmpty) return;

  //   List<Location> locations = await locationFromAddress(query);
  //   if (locations.isNotEmpty && gmapController != null) {
  //     final loc = LatLng(locations.first.latitude, locations.first.longitude);

  //     // Move camera
  //     await gmapController!.animateCamera(
  //       CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 15.0)),
  //     );

  //     // Add marker

  //     _searchedMarker = Marker(
  //       markerId: const MarkerId("searched"),
  //       position: loc,
  //       infoWindow: InfoWindow(title: query),
  //     );

  //     // Update cubit location
  //     widget.context.read<MapCubit>().updateLocation(loc);

  //     // Update the shared controller (so it reflects in the Contact form)
  //     _searchController.text = query;
  //   }
  // }

  // /// Reverse geocode to get full address
  // Future<void> _updateAddress(LatLng loc) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       loc.latitude,
  //       loc.longitude,
  //     );
  //     final placemark = placemarks.first;
  //   } catch (e) {
  //     debugPrint("Reverse geocode error: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      // listener: (context, state) async {
      //   if (state.location != null && gmapController != null) {
      //     // Animate camera to the new location
      //     await gmapController!.animateCamera(
      //       CameraUpdate.newCameraPosition(
      //         CameraPosition(target: state.location!, zoom: 15.0),
      //       ),
      //     );

      //     // Update searched marker
      //     (() {
      //       _searchedMarker = Marker(
      //         markerId: const MarkerId("searched"),
      //         position: state.location!,
      //         infoWindow: const InfoWindow(title: "Selected Location"),
      //       );
      //     });

      //     // Update address in cubit
      //     context.read<MapCubit>().updateLocation(state.location!);
      //   }
      // },
      listener: (context, state) async {
        if (state.location != null && gmapController != null) {
          await gmapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: state.location!, zoom: 15.0),
            ),
          );

          setState(() {
            _searchedMarker = Marker(
              markerId: const MarkerId("selected"),
              position: state.location!,
              infoWindow: const InfoWindow(title: "Selected Location"),
            );
          });
        }
      },

      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
              zoomGesturesEnabled: true,
              onLongPress: (LatLng position) {
                // Update cubit location on long press
                context.read<MapCubit>().updateLocation(position);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: true,
              trafficEnabled: true,
              mapType: _mapType,
              zoomControlsEnabled: true,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
              },
              initialCameraPosition: CameraPosition(
                target: state.location ?? LatLng(DEFULT_LAG, DEFULT_LNG),
                zoom: 5.0,
              ),
              markers: {
                // markers: {
                //   if (_searchedMarker != null) _searchedMarker!,
                // },

                if (_searchedMarker != null)
                  Marker(
                    markerId: const MarkerId("current"),
                    position: state.location!,
                  ),
                if (_searchedMarker != null) _searchedMarker!,
              },
              onMapCreated: (GoogleMapController controller0) {
                controller.complete(controller0);
                gmapController = controller0;
              },
            ),

            /// Search bar
//             Positioned(
//               top: 16,
//               left: 16,
//               right: 16,
//               child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(color: Colors.black26, blurRadius: 6),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: _searchController,
//                     onChanged: (val) {},
//                     decoration: const InputDecoration(
//                       hintText: "Search location",
//                       border: InputBorder.none,
//                       icon: Icon(Icons.search),
//                     ),
//                     onSubmitted: (val) {
//                       context
//                           .read<MapCubit>()
//                           .getCoordinates(val); // ✅ actually calls the function
// // search when user presses enter
//                     },
//                   )),
//             ),

            /// My Location + Layers buttons
            Positioned(
              bottom: 20,
              right: 20,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    heroTag: "myLocation",
                    onPressed: () {
                      context.read<MapCubit>().getCurrentLocation();

                      if (state.location != null && gmapController != null) {
                        gmapController!.animateCamera(
                          CameraUpdate.newLatLng(state.location!),
                        );
                      }
                    },
                    child: const Icon(Icons.my_location),
                  ),
                  const SizedBox(height: 10),
                  FloatingActionButton.small(
                    heroTag: "layers",
                    onPressed: () {
                      setState(() {
                        if (_mapType == MapType.normal) {
                          _mapType = MapType.satellite;
                        } else if (_mapType == MapType.satellite) {
                          _mapType = MapType.terrain;
                        } else if (_mapType == MapType.terrain) {
                          _mapType = MapType.hybrid;
                        } else {
                          _mapType = MapType.normal;
                        }
                      });
                    },
                    child: const Icon(Icons.layers),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
