import 'dart:convert';
import 'dart:io';

import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:provider/provider.dart';

class ReceiptSettingsScreen extends StatefulWidget {
  final Receipt receipt;
  final bool newReceipt;

  ReceiptSettingsScreen({this.receipt, this.newReceipt});

  @override
  _ReceiptSettingsScreenState createState() => _ReceiptSettingsScreenState();
}

class _ReceiptSettingsScreenState extends State<ReceiptSettingsScreen> {
  static IconData _fireIcon = FontAwesomeIcons.fire;
  static IconData _timerIcon = Icons.timer;
  static IconData _turnsIcon = Icons.repeat;

  static double _maxChildSize = 0.6;
  static double _minChildSize = 0.15;

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    int durationIndex = 0;
    Color _bgColor = Colors.blue[100];

    myController.text = widget.receipt.name;

    TableRow turnsRow = TableRow(
      children: <Widget>[
        Icon(_turnsIcon),
        Text(''),
        SliderTheme(
          data: SliderTheme.of(context),
          child: Slider(
            value: widget.receipt.turns.toDouble(),
            divisions: 4,
            min: 0,
            max: 4,
            //activeColor: Color(0xFFEB1555),
            onChanged: (double newValue) {
              setState(() {
                widget.receipt.setTurns(newValue.toInt());
              });
            },
          ),
        ),
        Text('${widget.receipt.turns}')
      ],
    );

    TableRow steeringRow = TableRow(
      children: <Widget>[
        Icon(_fireIcon),
        Text(''),
        SliderTheme(
          data: SliderTheme.of(context),
          child: Slider(
            value: widget.receipt.steeringSetting.value,
            divisions: 12,
            min: 0.0,
            max: 60.0,
            //activeColor: Color(0xFFEB1555),
            onChanged: (double newValue) {
              setState(() {
                widget.receipt.steeringSetting.value = newValue;
              });
            },
          ),
        ),
        Text('${widget.receipt.steeringSetting.value}')
      ],
    );

    TableRow minutesRow = TableRow(
      children: <Widget>[
        Icon(_timerIcon),
        Text('\''),
        SliderTheme(
          data: SliderTheme.of(context),
          child: Slider(
            value: widget.receipt.getMinutes(durationIndex).toDouble(),
            divisions: 30,
            min: 0.0,
            max: 30.0,
            //activeColor: Color(0xFFEB1555),
            onChanged: (double newValue) {
              setState(() {
                widget.receipt.setMinutes(durationIndex, newValue.round());
              });
            },
          ),
        ),
        Text('${widget.receipt.getMinutes(durationIndex)} \'')
      ],
    );

    TableRow secondsRow = TableRow(
      children: <Widget>[
        Icon(_timerIcon),
        Text('\'\''),
        SliderTheme(
          data: SliderTheme.of(context),
          child: Slider(
            value: widget.receipt.getSeconds(durationIndex).toDouble(),
            divisions: 12,
            min: 0.0,
            max: 60.0,
            //activeColor: Color(0xFFEB1555),
            onChanged: (double newValue) {
              setState(() {
                widget.receipt.setSeconds(durationIndex, newValue.round());
              });
            },
          ),
        ),
        Text('${widget.receipt.getSeconds(durationIndex)} \'\'')
      ],
    );

    Widget draggableLogo = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          height: screenHeight * 0.003,
          width: screenWidth * 0.1,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        ),
      ],
    );

    Widget spaceSmall = SizedBox(height: screenHeight * 0.01);
    Widget spaceBig = SizedBox(height: screenHeight * 0.05);
    Widget headerTile = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(_timerIcon),
        Text('${widget.receipt.getMinutes(durationIndex)}:${widget.receipt.getSeconds(durationIndex)}'),
        SizedBox(width: screenWidth * 0.03),
        Icon(_fireIcon),
        Text('${widget.receipt.steeringSetting.value}'),
        if (widget.receipt.turns > 0) SizedBox(width: screenWidth * 0.03),
        if (widget.receipt.turns > 0) Icon(_turnsIcon),
        if (widget.receipt.turns > 0) Text('${widget.receipt.turns}'),
        SizedBox(width: screenWidth * 0.1),
        Container(
          width: screenWidth * 0.1,
          child: Material(
              shape: CircleBorder(),
              color: Colors.white,
              elevation: 1,
              child: Ink(
                  //decoration: const ShapeDecoration(shape: CircleBorder(), color: Colors.lightBlueAccent),
                  child: IconButton(
                icon: Icon(Icons.save),
                color: Colors.black,
                onPressed: () async {
                  print('Save Button Pressed');
                  Provider.of<ReceiptData>(context).receiptList.addReceipt(Receipt.copy(widget.receipt));
                  await FileIO().writeString(jsonEncode(Provider.of<ReceiptData>(context).receiptList));
                },
              ))),
        )
      ],
    );
    Widget textField = Container(
      padding: EdgeInsets.only(left: screenWidth * 0.15, right: screenWidth * 0.15),
      child: TextFormField(
        //controller: myController,
        initialValue: widget.receipt.name,
        autofocus: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: "enter receipt name"),
        onChanged: (newText) {
          setState(() {
            //update name through receipt_data and receiver
            widget.receipt.name = newText;
          });
        },
      ),
    );
    Widget table = Container(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(0.07),
          1: FractionColumnWidth(0.02),
          2: FlexColumnWidth(1),
          3: FractionColumnWidth(0.1),
        },
        children: [minutesRow, secondsRow, steeringRow, turnsRow],
      ),
    );

    List<Widget> dragableItems = [draggableLogo, spaceSmall, headerTile, spaceBig, textField, table];

    return DraggableScrollableSheet(
      initialChildSize: widget.newReceipt ? _maxChildSize : _minChildSize,
      maxChildSize: _maxChildSize,
      minChildSize: _minChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.001, horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: _bgColor,
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: dragableItems.length,
            itemBuilder: (BuildContext context, int index) {
              return dragableItems[index];
            },
          ),
        );
      },
    );
  }
}
