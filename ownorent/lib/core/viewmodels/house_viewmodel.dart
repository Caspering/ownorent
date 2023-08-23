// ignore_for_file: prefer_final_fields

import 'dart:io';
import 'dart:math' show cos, sqrt, asin;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ownorent/core/services/firebase_storage.dart';

import '../models/house_model.dart';
import '../services/api.dart';

class HouseViewmodel extends ChangeNotifier {
  Api _api = Api("houses");
  List<House> houses = [];
  List<House> feed = [];
  List<House> userHomes = [];
  House? _currentHouse;
  House? get currentHouse => _currentHouse;
  String? _paymentType;
  String? get paymentType => _paymentType;
  setPaymentType(type) {
    _paymentType = type;
    notifyListeners();
  }

  String? _houseType;
  String? get houseType => _houseType;
  setHouseType(type) {
    _houseType = type;
    notifyListeners();
  }

  String? _bedroomNumber;
  String? get bedroomNumber => _bedroomNumber;
  setBedroomNumber(number) {
    _bedroomNumber = number;
    notifyListeners();
  }

  String? _bathroomNumber;
  String? get bathroomNumber => _bathroomNumber;
  setBathroomNumber(number) {
    _bathroomNumber = number;
    notifyListeners();
  }

  String? _description;
  String? get description => _description;
  setDesc(desc) {
    _description = desc;
  }

  double? _houseLat;
  double? get houseLat => _houseLat;
  setHouseLat(lat) {
    _houseLat = lat;
  }

  double? _houseLong;
  double? get houseLong => _houseLong;
  setHouseLong(long) {
    _houseLong = long;
  }

  String? _address;
  String? get address => _address;
  setAddress(add) {
    _address = add;
  }

  String? _area;
  String? get area => _area;
  setArea(a) {
    _area = a;
  }

  String? _price;
  String? get price => _price;
  setPrice(p) {
    _price = p;
  }

  List<String> _homeImages = [];
  List<String> get homeImages => _homeImages;
  setHomeImages(List images) async {
    for (int i = 0; i < images.length; i++) {
      String imageUrl = await Storage().uploadImage(
          images[i], DateTime.now().toIso8601String(), "homeImages");
      _homeImages.add(imageUrl);
      print(imageUrl);
    }
    print(_homeImages);
    return _homeImages;
  }

  List<File> _fileImages = [];
  List<File> get fileImages => _fileImages;
  addFileImages(image) {
    _fileImages.add(image);
    notifyListeners();
  }

  removeFileImage(image) {
    _fileImages.remove(image);
    notifyListeners();
  }

  setCurrentHouse(house) {
    _currentHouse = house;
  }

  Future addHouse(House data) {
    return _api.addData(data.toJson());
  }

  Future<List<House>> getAllHouses() async {
    var result = await _api.getDocuments();
    houses = result.docs
        .map((doc) => House.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return houses;
  }

  Future<List<String>> getHouseOwnersList() async {
    List<House> allHouses = await getAllHouses();
    List<String> owners = [];
    for (House house in allHouses) {
      owners.add(house.ownersId ?? "");
    }
    return owners;
  }

  Future<House> getHouseById(id) async {
    var result = await _api.getDocumentById(id);
    return House.fromMap(result.data() as Map<String, dynamic>, result.id);
  }

  Future<List<House>> getShortLets() async {
    var result = await _api.getWhereIsEqualTo('Shortlet', "type");
    final List<House> houses = result.docs
        .map((doc) => House.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return houses;
  }

  Future<List<House>> getFeed(LatLng userCoordinates, String purpose) async {
    var result = await _api.getOrderedDocuments("dateAdded", true);

    // Assuming that the data returned from the API is of type List<House>
    final List<House> houses = result.docs
        .map((doc) => House.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    // Make sure that the House objects are correctly converted and have valid data

    final List<House> purposeHouses = houses.where((element) {
      if (purpose == "Shortlet") {
        return element.type == "shortlet";
      } else if (purpose == "Buy") {
        return element.type != "shortlet";
      } else {
        return true;
      }
    }).toList();
    final List<House> feed = purposeHouses.where((element) {
      final proximity = _distanceBetween(
        element.locationLat ?? 0.0,
        element.locationLong ?? 0.0,
        userCoordinates.latitude,
        userCoordinates.longitude,
      );
      return proximity <= 300;
    }).toList();

    return feed;
  }

  double _distanceBetween(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  Future<List<House>> getUserHomes(userId) async {
    var result = await _api.getWhereIsEqualTo(userId, "ownersId");
    userHomes = result.docs
        .map((doc) => House.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return userHomes;
  }
}
