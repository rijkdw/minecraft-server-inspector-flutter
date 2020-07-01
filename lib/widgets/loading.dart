import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FullScreenLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCubeGrid(
        size: 50,
        color: Colors.green,
      ),
    );
  }
}

class FullScreenErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.error,
        size: 100,
        color: Colors.red,
      ),
    );
  }
}

class FullScreenInitialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/grassblock.png',
            scale: 1.5,
          ),
          SizedBox(height: 30),
          Text(
            'Welcome',
            style: TextStyle(letterSpacing: 2, fontSize: 26),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
