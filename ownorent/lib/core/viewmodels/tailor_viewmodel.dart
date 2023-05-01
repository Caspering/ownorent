import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TailorViewmodel extends ChangeNotifier {
  static const roles = "roles";
  static const locations = 'location';
  static const lats = "lat";
  static const longs = "long";
  String? _location;
  String? get location => _location;
  String? _role;
  String? get role => _role;
  double? _lat;
  double? _long;
  double? get lat => _lat;
  double? get long => _long;
  setRole(rl) {
    _role = rl;
    notifyListeners();
  }

  setCoordinates(la, lo) {
    _lat = la;
    _long = lo;
    notifyListeners();
  }

  setSaveLocation(slc) {
    _location = slc;
    notifyListeners();
  }

  addLocation(location, long, lat) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(locations, location);
    pref.setDouble(lats, lat);
    pref.setDouble(longs, long);
  }

  getLocation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String savedLocation = pref.getString(locations) ?? "";
    setSaveLocation(savedLocation);
    double userlat = pref.getDouble(lats) ?? 0.0;
    double userlong = pref.getDouble(longs) ?? 0.0;
    setCoordinates(userlat, userlong);
  }

  addRole(role) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(roles, role);
  }

  getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String savedRole = pref.getString(roles) ?? "";
    setRole(savedRole);
  }

  Future<Map<String, dynamic>> searchLocation(String query) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/find?q=$query&appid=826c25e35ac9d88e6d057ddfe32a59ef&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['list'];
      print(data);
      if (data.isNotEmpty) {
        return data[0];
      } else {
        throw Exception('No locations found for query: $query');
      }
    } else {
      throw Exception('Failed to search locations: ${response.statusCode}');
    }
  }

  Future<String> getUserLocation(LatLng coordinates) async {
    List<Placemark?> addresses = await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
    Placemark firstL;
    String locality;
    if (addresses != null) {
      firstL = addresses.first!;
      locality = firstL.locality ?? "";
      return locality;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
