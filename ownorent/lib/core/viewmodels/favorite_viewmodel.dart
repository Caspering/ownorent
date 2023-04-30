import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteViewModel extends ChangeNotifier {
  List<String>? _favoriteIds;
  List<String>? get favoriteIds => _favoriteIds;
  setFavorites(faves) {
    _favoriteIds = faves;
  }

  addOrRemove(id) {
    if (_favoriteIds!.contains(id)) {
      _favoriteIds?.remove(id);
    } else {
      _favoriteIds?.add(id);
    }
    addToFavourites(_favoriteIds);
    notifyListeners();
  }

  static const favorites = "favourites";
  addToFavourites(faves) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setStringList(favorites, faves);
  }

  getFavourites() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> saveId = pref.getStringList(favorites) ?? [];
    setFavorites(saveId);
  }
}
