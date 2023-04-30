import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ownorent/core/services/api.dart';

import '../models/user_model.dart';
import '../services/firebase_storage.dart';

class UserViewmodel extends ChangeNotifier {
  final _api = Api("users");
  String? _firstName;
  String? _lastName;
  String? get firstname => _firstName;
  File? _image;
  String? get lastname => _lastName;
  File? get image => _image;
  String? get phoneNumber => _phoneNumber;
  String? _phoneNumber;
  Users? _currentUser;
  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  Users? get currentUser => _currentUser;
  String? _role;
  String? get role => _role;
  setRole(rl) {
    _role = rl;
    notifyListeners();
  }

  Future<void> setImageUrl(image, uid) async {
    _imageUrl = await Storage().uploadImage(image, uid, "users");
  }

  Future<Users?> getUserById(uid) async {
    var result = await _api.getDocumentById(uid);

    return Users.fromMap(result.data() as Map<String, dynamic>, result.id);
  }

  Future<bool> checkIfUser(userId) async {
    var result = await _api.getDocumentById(userId);
    if (result.exists) {
      setCurrentUser(
          Users.fromMap(result.data() as Map<String, dynamic>, result.id));
      return true;
    } else {
      return false;
    }
  }

  updateUserName(firstname, lastname, uid) {
    _api.updateDocumentMap({"firstname": firstname, "lastname": lastname}, uid);
  }

  updateProfilePhoto(imageUrl, uid) {
    _api.updateDocument("profilePhoto", imageUrl, uid);
  }

  setCurrentUser(cUser) {
    _currentUser = cUser;
  }

  adduser(Users data, userId) {
    return _api.setData(data.toJson(), userId);
  }

  setImage(photo) {
    _image = photo;
    notifyListeners();
  }

  void setFirstname(text) {
    _firstName = text;
  }

  void setLastname(text) {
    _lastName = text;
  }

  void setPhoneNumber(text) {
    _phoneNumber = text;
  }
}
