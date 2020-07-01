import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mcserverinspector/models/server.dart';
import 'package:mcserverinspector/widgets/grassblock.dart';

class ServerInfo extends StatelessWidget {
  final Server server;
  ServerInfo({@required this.server});

  String _constructSubtitle() {
    String subtitle = '';
    String separator = '  •  ';
    List<String> values = [server.ip, server.version, server.software];
    for (String val in values) {
      if (val != null && val != '') {
        subtitle += '$val$separator';
      }
    }
    int lastSeparatorIndex = subtitle.lastIndexOf(separator);
    try {
      return subtitle.substring(0, lastSeparatorIndex);
    } catch (e) {
      return '(no info to show)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            server.hostname ?? 'Unnamed server',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            _constructSubtitle(),
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          server.cleanMOTD == '' || server.cleanMOTD == null
              ? Container()
              : GrassBlock(
                  title: 'MOTD',
                  content: Text(
                    server.cleanMOTD,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  fillWidth: true,
                ),
          SizedBox(height: 20),
          server.online
              ? PlayerList(
                  playerNames: server.playerNames ?? [],
                  maxPlayers: server.maxPlayers,
                  currentPlayers: server.currentPlayers,
                )
              : Container(),
        ],
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  final List<String> playerNames;
  final int currentPlayers;
  final int maxPlayers;
  PlayerList({this.playerNames, this.maxPlayers, this.currentPlayers});

  @override
  Widget build(BuildContext context) {
    return GrassBlock(
      title: '${currentPlayers ?? '0'}/${maxPlayers ?? '0'} players online',
      content: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: playerNames.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: playerNames.length,
                itemBuilder: (context, index) {
                  return PlayerCard(
                    playerName: playerNames[index],
                  );
                },
              )
            : Text(
                'No player names',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class PlayerCard extends StatelessWidget {
  final String playerName;
  PlayerCard({this.playerName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        playerName,
        style: TextStyle(fontSize: 18),
      ),
      leading: FadeInImage(
        image: NetworkImage('https://minotar.net/helm/$playerName/32.png'),
        placeholder: AssetImage('images/steve.png'),
        fadeInDuration: Duration(milliseconds: 500),
        fadeOutDuration: Duration(milliseconds: 500),
      ),
    );
  }
}
