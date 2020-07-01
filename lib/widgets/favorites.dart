import 'package:flutter/material.dart';
import 'package:mcserverinspector/services/servermanager.dart';
import 'package:provider/provider.dart';

class SearchFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.search,
      ),
      onPressed: () => Provider.of<ServerManager>(context, listen: false).searchForServerDialog(context),
    );
  }
}

