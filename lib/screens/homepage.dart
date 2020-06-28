import 'package:flutter/material.dart';
import 'package:mcserverinspector/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      drawer: AppDrawer(),
    );
  }
}
