import 'package:flutter/material.dart';
import 'package:mcserverinspector/services/favoritesmanager.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<FavoritesManager>(
      builder: (context, favoritesManager, child) {
        return ListView.builder(
          itemCount: favoritesManager.favorites.length,
          itemBuilder: (context, index) {
            String server = favoritesManager.favorites[index];
            return ListTile(
              title: Text(server),
            );
          },
        );
      },
    ));
  }
}
