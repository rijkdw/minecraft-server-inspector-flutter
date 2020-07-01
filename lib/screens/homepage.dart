import 'package:flutter/material.dart';
import 'package:mcserverinspector/models/server.dart';
import 'package:mcserverinspector/services/favoritesmanager.dart';
import 'package:mcserverinspector/services/servermanager.dart';
import 'package:mcserverinspector/widgets/drawer.dart';
import 'package:mcserverinspector/widgets/favorites.dart';
import 'package:mcserverinspector/widgets/loading.dart';
import 'package:mcserverinspector/widgets/serverinfo.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      floatingActionButton: SearchFab(),
      body: Consumer<ServerManager>(builder: (context, serverManager, child) {
        if (serverManager.loading) return FullScreenLoadingWidget();
        if (serverManager.error) return FullScreenErrorWidget();
        if (serverManager.initial) return FullScreenInitialWidget();
        return ServerInfo(server: serverManager.server);
      }),
      appBar: AppBar(
//        elevation: 0,
        title: Consumer<ServerManager>(
          builder: (context, serverManager, child) {
            if (!serverManager.loading && !serverManager.error && !serverManager.initial)
              return Text(
                serverManager.server.online ? 'Online' : 'Offline',
                style: TextStyle(
                  color: serverManager.server.online ? Colors.white : Colors.red,
                ),
              );
            return Container();
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ServerManager>(
            builder: (context, serverManager, child) {
              if (!serverManager.loading && !serverManager.error && !serverManager.initial)
                return Container(
                  width: 40,
                  child: InkWell(
                    child: Consumer<FavoritesManager>(
                      builder: (context, favoritesManager, child) {
                        Server server = Provider.of<ServerManager>(context, listen: false).server;
                        return InkWell(
                          child: Icon(
                            favoritesManager.favorites.contains(server.hostname) || favoritesManager.favorites.contains(server.ip)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onTap: () {
                            if (favoritesManager.favorites.contains(server.hostname)) {
                              favoritesManager.removeFavorite(server.hostname);
                            } else if (favoritesManager.favorites.contains(server.ip)) {
                              favoritesManager.removeFavorite(server.ip);
                            } else {
                              favoritesManager.addFavorite(server.hostname ?? server.ip);
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              return Container();
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
