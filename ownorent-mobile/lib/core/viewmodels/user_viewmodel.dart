import 'package:flutter/material.dart';
import 'package:ownorent/core/services/api.dart';

import '../models/user_model.dart';
import '../services/firebase_storage.dart';

class UserViewmodel extends ChangeNotifier {
  final _api = Api("users");
  Users? _currentUser;
  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  Users? get currentUser => _currentUser;
  Future<void> setImageUrl(image, uid) async {
    _imageUrl = await Storage().uploadImage(image, uid, "users");
  }

  Future<Users?> getUserById(uid) async {
    var result = await _api.getDocumentById(uid);

    return Users.fromMap(result.data() as Map<String, dynamic>, result.id);
  }

  setCurrentUser(cUser) {
    _currentUser = cUser;
  }

  adduser(Users data) {
    return _api.addData(data.toJson());
  }
}
