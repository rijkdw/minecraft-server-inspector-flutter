import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager extends ChangeNotifier {
  List<String> _favorites = [];
  List<String> get favorites => _favorites;

  String _favoritesKey = 'favoriteServers';

  FavoritesManager() {
    _loadFavorites();
  }

  void _loadFavorites() async {
    var prefs = await SharedPreferences.getInstance();
    var favoritesJson = prefs.getString(_favoritesKey);
    var favoritesParsed = json.decode(favoritesJson) as List<dynamic>;
    _favorites = favoritesParsed.map((fav) => fav.toString()).toList();
    notifyListeners();
  }

  void _storeFavorites() async {
    var prefs = await SharedPreferences.getInstance();
    var favoritesJson = json.encode(_favorites);
    prefs.setString(_favoritesKey, favoritesJson);
  }

  void addFavorite(String address) {
    if (!_favorites.contains(address))
      _favorites.add(address);
    _storeFavorites();
    notifyListeners();
  }

  void removeFavorite(String address) {
    _favorites.remove(address);
    _storeFavorites();
    notifyListeners();
  }

  void showNewFavoriteServerDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    Alert(
      context: context,
      title: "Add new favorite server",
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Address',
          ),
          controller: textEditingController,
        ),
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            if (textEditingController.text.trim().length > 0) {
              addFavorite(textEditingController.text);
            }
            Navigator.pop(context);
          },
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ).show();
  }
}
