import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container getSeparatorLine(double screenHeight, double screenWidth) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    height: screenHeight * 0.002,
    width: screenWidth * 0.4,
    decoration:
        BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10.0)), //TODO: take background color
  );
}

Widget getSeparator(IconData icon, double screenHeight, double screenWidth) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      getSeparatorLine(screenHeight, screenWidth),
      Icon(icon),
      getSeparatorLine(screenHeight, screenWidth),
    ],
  );
}
