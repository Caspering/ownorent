import 'dart:async';
import 'dart:math';

import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownorent/core/models/house_model.dart';
import 'package:ownorent/core/services/location_service.dart';
import 'package:ownorent/core/viewmodels/house_viewmodel.dart';
import 'package:ownorent/ui/views/house_detail_view.dart';
import 'package:provider/provider.dart';

import '../../utils/router.dart';

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
  void getLongLat() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      start = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    LocationService _location = Provider.of<LocationService>(context);
    HouseViewmodel _houseViewmodel = Provider.of<HouseViewmodel>(context);
    return Scaffold(
        body: FutureBuilder<List<House>>(
            future: _houseViewmodel.getAllHouses(),
            builder: ((context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                Set<Marker> list = <Marker>{};
                List markerColors = [
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueCyan),
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue),
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueYellow),
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange),
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure),
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueViolet),
                  BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueMagenta)
                ];
                final random = Random();
                for (var mat in snapshot.data!) {
                  list.add(Marker(
                      markerId: MarkerId(mat.id ?? ""),
                      icon: markerColors[random.nextInt(markerColors.length)],
                      onTap: () {
                        _houseViewmodel.setCurrentHouse(mat);
                        RouteController().push(context, HouseDetailView());
                      },
                      position: LatLng(
                          mat.locationLat ?? 0.0, mat.locationLong ?? 0.0)));
                }
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: _location.userCoordinates ?? LatLng(0.0, 0.0),
                      zoom: 12),
                  markers: list,
                );
              } else {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: _location.userCoordinates ?? LatLng(0.0, 0.0),
                      zoom: 12),
                  markers: {
                    Marker(
                        markerId: MarkerId("source"),
                        position:
                            _location.userCoordinates ?? LatLng(0.0, 0.0)),
                  },
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                );
              }
            })));
  }
}
