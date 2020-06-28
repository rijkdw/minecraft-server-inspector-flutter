import 'dart:convert';

import 'package:http/http.dart';

void main() async {
  Response response = await get('https://api.mcsrvstat.us/2/gatedcommunity.servebeer');
  var body = json.decode(response.body);
  print(body['motd'] ?? 'not found');
  print((body['motd'] ?? {})['clean'] ?? 'not found');
}
