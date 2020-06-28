import 'package:flutter/material.dart';
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
        ChangeNotifierProvider(create: (_) => FavoritesManager()),
        ChangeNotifierProvider(create: (_) => ServerManager(),)
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
