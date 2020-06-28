import 'package:flutter/material.dart';

class FavoritesManager extends ChangeNotifier {

  List<String> _favorites = ['gatedcommunity.servebeer.com'];

  List<String> get favorites => _favorites;

  void addFavorite(String address) {
    _favorites.add(address);
    notifyListeners();
  }

  void removeFavorite(String address) {
    _favorites.remove(address);
    notifyListeners();
  }

}
