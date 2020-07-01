import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GrassBlock extends StatelessWidget {
  final Widget content;
  final String title;
  final bool fillWidth;
  GrassBlock({@required this.content, this.title: '', this.fillWidth: false});

  final double _borderWidth = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.green[500],
            border: Border.all(
              width: _borderWidth,
              color: Colors.green[800],
            ),
          ),
          child: Text(
            this.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.5),
          ),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.brown[300].withOpacity(0.8),
            border: Border(
              bottom: BorderSide(width: _borderWidth, color: Colors.brown),
              left: BorderSide(width: _borderWidth, color: Colors.brown),
              right: BorderSide(width: _borderWidth, color: Colors.brown),
            ),
          ),
          child: content,
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[200],
        border: Border(
          top: BorderSide(width: 10, color: Colors.green),
        ),
      ),
      child: Container(
          alignment: Alignment.center,
          width: fillWidth ? double.infinity : null,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 3, color: Colors.brown),
              right: BorderSide(width: 3, color: Colors.brown),
              bottom: BorderSide(width: 3, color: Colors.brown),
            ),
          ),
          child: content),
    );
  }
}
