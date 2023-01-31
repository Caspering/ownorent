import 'package:flutter/material.dart';

import '../models/house_model.dart';
import '../services/api.dart';

class HouseViewmodel extends ChangeNotifier {
  Api _api = Api("houses");
  List<House> houses = [];
  House? _currentHouse;
  House? get currentHouse => _currentHouse;
  setCurrentHouse(house) {
    _currentHouse = house;
  }

  Future addHouse(House data) {
    return _api.addData(data.toJson());
  }

  Future<List<House>> getAllHouses() async {
    var result = await _api.getDocuments();
    houses = result.docs
        .map((doc) => House.fromMap(doc as Map<String, dynamic>, doc.id))
        .toList();
    return houses;
  }
}
