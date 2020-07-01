import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mcserverinspector/services/favoritesmanager.dart';
import 'package:mcserverinspector/services/servermanager.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          AppDrawerHeader(),
          FavoriteServersList(),
        ],
      ),
    );
  }
}

class AppDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: DrawerHeader(
        margin: EdgeInsets.all(0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Minecraft Server Lookup Tool',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green[800],
              Colors.green,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

class FavoriteServersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesManager>(
      builder: (context, favoritesManager, child) {
        return ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            'Favorite Servers',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          children: [
            ...favoritesManager.favorites.map((server) => FavoriteServerWidget(address: server)).toList(),
            // Add Server button
            ListTile(
              title: Text(
                'Add Server',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: true,
              trailing: Container(
                width: 28,
                child: Icon(
                  Icons.add,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              onTap: () => Provider.of<FavoritesManager>(context, listen: false).showNewFavoriteServerDialog(context),
            ),
            ListTile(
              title: Text(
                'View Dummy Server',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              dense: true,
              trailing: Container(
                width: 28,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              onTap: () {
                Provider.of<ServerManager>(context, listen: false).fetchDummyServer();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class FavoriteServerWidget extends StatelessWidget {
  final String address;
  FavoriteServerWidget({this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(address),
      onTap: () {
        Provider.of<ServerManager>(context, listen: false).fetchServer(address);
        Navigator.of(context).pop();
      },
      trailing: Container(
        width: 39,
        child: FlatButton(
          child: Icon(
            Icons.close,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () => Provider.of<FavoritesManager>(context, listen: false).removeFavorite(address),
        ),
      ),
    );
  }
}
