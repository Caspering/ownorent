import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapview extends StatefulWidget {
  const Mapview({super.key});

  @override
  State<Mapview> createState() => _MapviewState();
}

class _MapviewState extends State<Mapview> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? newController;
  List<LatLng> polylineCoordinates = [];
  LatLng? start;
  LatLng? dest;
  Position? currentLocation;
  var markerIcon;
  @override
  initState() {
    getLongLat();

    updateLocation();

    super.initState();
  }

  void updateLocation() async {
    Geolocator.getCurrentPosition().then((value) {
      currentLocation = value;
      print(value);
    });

    GoogleMapController googleMapController = await _controller.future;
    Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best)
        .listen((Position position) {
      currentLocation = position;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18)));
      //   print(position.latitude);
      setState(() {});
    });
  }

  void getLongLat() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      start = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition:
          CameraPosition(target: LatLng(37.33233141, -122.0312186), zoom: 12),
      markers: {
        Marker(
            markerId: MarkerId("source"),
            position: LatLng(37.33233141, -122.0312186)),
      },
      onMapCreated: (mapController) {
        _controller.complete(mapController);
      },
    ));
  }
}
