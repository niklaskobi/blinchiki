import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blinchiki_app/data/constants.dart';

Widget getNumberField(
  double initValue,
  String label,
  double fontSize,
) {
  return Container(
    color: kReceiptCardBackground,
    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 13.0),
    margin: EdgeInsets.all(5.0),
    child: TextFormField(
      initialValue: initValue.toString(),
      autofocus: false,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          )),
      onChanged: (newText) {},
      onSaved: (newText) {
        print('onSaved');
      },
      keyboardType: TextInputType.number,
      //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Only numbers can be entered
      onFieldSubmitted: (newText) {
        print(newText);
      },
    ),
  );
}
