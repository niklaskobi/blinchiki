import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blinchiki_app/data/constants.dart';

Widget getNumberField(
  double initValue,
  String label,
  double fontSize,
) {
  final double _circularBorder = 5.0;
  final double _marginHorizonal = 10.0;
  final double _marginVertical = 3.0;
  final double _paddingHorizontal = 13.0;
  final double _paddingVertical = 1.0;
  return Container(
    decoration: BoxDecoration(color: kReceiptCardBackground, borderRadius: BorderRadius.circular(_circularBorder)),
    padding: EdgeInsets.symmetric(vertical: _paddingVertical, horizontal: _paddingHorizontal),
    margin: EdgeInsets.symmetric(vertical: _marginVertical, horizontal: _marginHorizonal),
    child: TextFormField(
      initialValue: initValue.toString(),
      autofocus: false,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey,
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
