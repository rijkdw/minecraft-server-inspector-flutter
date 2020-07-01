import 'dart:developer';

class Server {

  bool online;
  String ip;
  String motd;
  int maxPlayers;
  int currentPlayers;
  List<String> playerNames;
  String version;
  String software;
  String hostname;

  Server({this.online, this.ip, this.motd, this.maxPlayers, this.currentPlayers, this.playerNames, this.version, this.software, this.hostname});

  String get cleanMOTD {
    RegExp regex = new RegExp(r"&.*?;");
    return '${this.motd.replaceAll(regex, '')}';
  }

  factory Server.fromAPI(Map<String, dynamic> json) {
    return Server(
      ip: json['ip'],
      software: json['software'],
      version: json['version'],
      maxPlayers: (json['players'] ?? {})['max'],
      currentPlayers: (json['players'] ?? {})['online'],
      motd: ((json['motd'] ?? {})['clean'] ?? []).join('\n'),
      hostname: json['hostname'],
      online: json['online'] ?? false,
      playerNames: (json['players'] ?? {})['list'] ?? []
    );
  }

  factory Server.dummy() {
    return Server(
      playerNames: ['MrBrickMonkey', 'Cujo26', 'BrickCase'],
      currentPlayers: 3,
      online: true,
      hostname: 'dummy.server.com',
      version: '1.16.1',
      motd: 'Welcome to the Dummy Server',
      ip: '127.0.0.1',
      maxPlayers: 20,
      software: 'Forge'
    );
  }
}
