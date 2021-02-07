import 'package:blinchiki_app/models/default_steering_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blinchiki_app/data/constants.dart';

class SteeringNumberParamWidget extends StatefulWidget {
  final double initValue;
  final String label;
  final double fontSize;
  final Function validateFunction;
  final Function updateValueFunction;
  final int activeReceipt;

  SteeringNumberParamWidget({
    @required this.initValue,
    @required this.label,
    @required this.fontSize,
    @required this.validateFunction,
    @required this.updateValueFunction,
    @required this.activeReceipt,
  });

  @override
  _SteeringNumberParamWidgetState createState() => _SteeringNumberParamWidgetState();
}

class _SteeringNumberParamWidgetState extends State<SteeringNumberParamWidget> {
  final double _circularBorder = 5.0;
  final double _marginHorizontal = 15.0;
  final double _marginVertical = 3.0;
  final double _paddingHorizontal = 20.0;
  final double _paddingVertical = 1.0;

  DefaultSteeringList defaultSteeringList = DefaultSteeringList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: kReceiptCardBackground, borderRadius: BorderRadius.circular(_circularBorder)),
      padding: EdgeInsets.symmetric(vertical: _paddingVertical, horizontal: _paddingHorizontal),
      margin: EdgeInsets.symmetric(vertical: _marginVertical, horizontal: _marginHorizontal),
      child: TextFormField(
        key: Key(widget.initValue.toString()),
        initialValue: widget.initValue.toString(),
        autofocus: false,
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: Colors.grey,
              fontSize: widget.fontSize,
            )),
        onSaved: (newText) {
          if (widget.validateFunction(newText)) {
            widget.updateValueFunction(newText);
          }
        },
        onFieldSubmitted: (newText) {
          if (widget.validateFunction(newText)) {
            widget.updateValueFunction(newText);
          }
        },
        keyboardType: TextInputType.number,
        //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Only numbers can be entered
      ),
    );
  }
}
