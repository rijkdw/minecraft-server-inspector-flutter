import 'package:flutter/material.dart';
import 'package:mcserverinspector/models/server.dart';
import 'package:mcserverinspector/services/favoritesmanager.dart';
import 'package:mcserverinspector/screens/homepage.dart';
import 'package:mcserverinspector/services/servermanager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return FavoritesManager();
        }),
        ChangeNotifierProvider(create: (_) {
          return ServerManager();
        }),
      ],
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.green,
          primaryColor: Colors.green,
        ),
        home: HomePage(),
      ),
    );
  }
}
