// ignore_for_file: prefer_final_fields

import 'dart:io';

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

  Future<List<House>> getFeed(String address) async {
    var result = await _api.getWhereIsEqualTo(address, "area");

    feed = result.docs
        .map((doc) => House.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    feed.shuffle();

    return feed.take(10).toList();
  }

  Future<List<House>> getUserHomes(userId) async {
    var result = await _api.getWhereIsEqualTo(userId, "ownersId");
    userHomes = result.docs
        .map((doc) => House.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return userHomes;
  }
}
