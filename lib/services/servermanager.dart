import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mcserverinspector/models/server.dart';
import 'package:mcserverinspector/services/favoritesmanager.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ServerManager extends ChangeNotifier {

  Server _server;
  Server get server => _server;

  // flags
  bool _error = false;
  bool get error => _error;

  bool _loading = false;
  bool get loading => _loading;

  bool _initial = true;
  bool get initial => _initial;

  void _setFlags({bool loading, bool error, bool initial}) {
    _loading = loading ?? _loading;
    _error = error ?? _error;
    _initial = initial ?? _initial;
    notifyListeners();
  }

  void refreshServer() {
    fetchServer(_server.hostname ?? _server.ip);
  }

  void fetchServer(String hostname) async {
    _setFlags(loading: true, error: false, initial: false);
    Response response = await get('https://api.mcsrvstat.us/2/$hostname');
    if (response.statusCode == 200) {
      _server = Server.fromAPI(json.decode(response.body));
      _setFlags(loading: false, error: false);
    } else {
      _setFlags(error: true, loading: false);
    }
    notifyListeners();
  }

  void fetchDummyServer() async {
    _setFlags(loading: true, error: false, initial: false);
    await Future.delayed(Duration(seconds: 2));
    _setFlags(loading: false);
    _server = Server.dummy();
    notifyListeners();
  }

  void searchForServerDialog(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    Alert(
      context: context,
      title: "Search for server",
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
              fetchServer(textEditingController.text);
            }
            Navigator.pop(context);
          },
          child: Text(
            "Search",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ).show();
  }

}