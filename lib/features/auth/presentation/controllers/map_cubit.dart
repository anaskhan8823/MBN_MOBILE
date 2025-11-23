import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapState());

  LatLng? selectedLocation;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    try {
      Position position = await Geolocator.getCurrentPosition();
      updateLocation(LatLng(position.latitude, position.longitude));
    } catch (e) {
      print('error:$e');
    }
  }

  Future<void> getCoordinates(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location loc = locations.first;
        updateLocation(LatLng(loc.latitude, loc.longitude));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void updateLocation(LatLng newLocation) {
    selectedLocation = newLocation;
    emit(state.copyWith(location: newLocation));
    print("UPDATEDs $newLocation");
  }
}

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

  // Future<void> _searchPlace(String query) async {
  //   try {
  //     if (query.isEmpty) return;
  //     List<Location> locations = await locationFromAddress(query);
  //     if (locations.isNotEmpty && gmapController != null) {
  //       final loc = LatLng(locations.first.latitude, locations.first.longitude);
  //       gmapController!.animateCamera(CameraUpdate.newLatLngZoom(loc, 15));

  //       setState(() {
  //         // Add marker for searched place
  //         _searchedMarker = Marker(
  //           markerId: const MarkerId("searched"),
  //           position: loc,
  //           infoWindow: InfoWindow(title: query),
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     debugPrint("Search error: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Location not found")),
  //     );
  //   }
  // }

  // Future<void> getCoordinatesFromAddress(String address) async {
  //   final url = Uri.parse(
  //     "https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=AIzaSyD06pJHHAMxmXPW9BRsHmLb8ZI8yxsa0tw",
  //   );

  //   try {
  //     final response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       if (data["status"] == "OK") {
  //         final location = data["results"][0]["geometry"]["location"];
  //         final lat = location["lat"];
  //         final lng = location["lng"];

  //         print("Latitude: $lat, Longitude: $lng");

  //         updateLocation(LatLng(lat, lng));
  //       } else {
  //         print("Geocoding failed: ${data["status"]}");
  //       }
  //     } else {
  //       print("Request failed: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  // void updateLocation(LatLng newLocation) {
  //   selectedLocation = newLocation;
  //   emit(state.copyWith(location: newLocation));
  //   print("UPDATEDs $newLocation");
  // }
// }
