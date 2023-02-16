import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import "package:geocoding/geocoding.dart";

class LocationService extends ChangeNotifier {
  LatLng? _userCoordinates;
  String? _location;
  LatLng? get userCoordinates => _userCoordinates;
  String? get location => _location;

  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    return position;
  }

  setCoordinates(coordinates) {
    _userCoordinates = coordinates;
  }

  setAddress(address) {
    _location = address;
    notifyListeners();
  }

  getAddress(LatLng position) async {
    List<Placemark> addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    var first = addresses.first;
    return first.locality;
  }

  Future<LatLng> getCoordinatesFromAddress(String area) async {
    List<Location> location = await locationFromAddress(area);
    var first = location.first;
    return LatLng(first.latitude, first.longitude);
  }
}
