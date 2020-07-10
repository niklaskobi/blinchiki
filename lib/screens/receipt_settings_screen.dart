import 'dart:convert';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:provider/provider.dart';
import 'package:blinchiki_app/functions/common.dart';
import 'package:blinchiki_app/widgets/table_row.dart';

class ReceiptSettingsScreen extends StatefulWidget {
  final int receiptIndex;

  ReceiptSettingsScreen({this.receiptIndex});

  @override
  _ReceiptSettingsScreenState createState() => _ReceiptSettingsScreenState();
}

class _ReceiptSettingsScreenState extends State<ReceiptSettingsScreen> {
  /// statics ----------------------------------------------
  static IconData _fireIcon = FontAwesomeIcons.fire;
  static IconData _timerIcon = Icons.timer;
  static IconData _turnsIcon = Icons.repeat;
  static double _maxChildSize = 0.6;
  static double _minChildSize = 0.15;
  final myController = TextEditingController();

  /// vars -------------------------------------------------
  int _timerIndex = 1;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final index = widget.receiptIndex;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double _rowHeight = screenHeight * 0.07;
    final Color _bgColor = Colors.blue[100];

    bool _newReceipt = false;
    int durationIndex = 0;
    myController.text = Provider.of<ReceiptList>(context).getReceiptByIndex(index).name;

    /// returns the timer index if turns counter is greater than 1
    String getTimerIndexStr() {
      int turns = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns;
      if (turns > 0)
        return '$_timerIndex / $turns';
      else
        return '';
    }

    /// increment the turns index when pressing on the timer icon
    void timerOnTap() {
      setState(() {
        if (Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns > 1) {
          _timerIndex = rotatingIncrement(
              this._timerIndex, 1, Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns);
        }
      });
    }

    /// turns row ----------------------------------------------------------------------------------------------------
    TableRow turnsRow = MyTableRow.createTableRow(
      _rowHeight,
      '',
      '',
      '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns}',
      _timerIcon,
      index,
      4,
      0.0,
      4.0,
      Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns.toDouble(),
      null,
      (double value) {
        setState(() {
          Provider.of<ReceiptList>(context, listen: false).setTurns(index, value.toInt());
        });
      },
      context,
    );

    /// steering row --------------------------------------------------------------------------------------------------
    TableRow steeringRow = MyTableRow.createTableRow(
      _rowHeight,
      '',
      '',
      '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).steeringSetting.value}',
      _fireIcon,
      index,
      12,
      0.0,
      60.0,
      Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).steeringSetting.value,
      null,
      (double newValue) {
        setState(() {
          Provider.of<ReceiptList>(context, listen: false).setSteering(index, newValue);
        });
      },
      context,
    );

    /// minutes row ---------------------------------------------------------------------------------------------------
    TableRow minutesRow = MyTableRow.createTableRow(
      _rowHeight,
      '${getTimerIndexStr()}',
      '\'',
      '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getMinutes(durationIndex)} \'',
      _timerIcon,
      index,
      30,
      0.0,
      30.0,
      Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getMinutes(durationIndex).toDouble(),
      timerOnTap,
      (double newValue) {
        setState(() {
          Provider.of<ReceiptList>(context, listen: false).setMinutes(index, durationIndex, newValue.round());
        });
      },
      context,
    );

    /// seconds row ---------------------------------------------------------------------------------------------------
    TableRow secondsRow = MyTableRow.createTableRow(
        _rowHeight,
        '${getTimerIndexStr()}',
        '\'\'',
        '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getSeconds(durationIndex)} \'\'',
        _timerIcon,
        index,
        11,
        0.0,
        55.0,
        Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getSeconds(durationIndex).toDouble(),
        timerOnTap, (double newValue) {
      setState(() {
        Provider.of<ReceiptList>(context, listen: false).setSeconds(index, durationIndex, newValue.round());
      });
    }, context);

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
        Text(
          '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getMinutes(durationIndex)}:' +
              '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getSeconds(durationIndex)}',
        ),
        SizedBox(width: screenWidth * 0.03),
        Icon(_fireIcon),
        Text('${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).steeringSetting.value}'),
        if (Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns > 0)
          SizedBox(width: screenWidth * 0.03),
        if (Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns > 0) Icon(_turnsIcon),
        if (Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns > 0)
          Text('${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).turns}'),
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
                  //Provider.of<ReceiptList>(context).addReceipt(Receipt.copy(_receipt));
                  await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
                },
              ))),
        )
      ],
    );
    Widget textField = Container(
      padding: EdgeInsets.only(left: screenWidth * 0.15, right: screenWidth * 0.15),
      child: TextFormField(
        //controller: myController,
        initialValue: Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).name,
        autofocus: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: "enter receipt name"),
        onChanged: (newText) {
          setState(() {
            //update name through receipt_data and receiver
            Provider.of<ReceiptList>(context, listen: false).setName(index, newText);
          });
        },
      ),
    );
    Widget table = Container(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(0.02),
          1: FractionColumnWidth(0.12),
          2: FractionColumnWidth(0.02),
          3: FlexColumnWidth(1),
          4: FractionColumnWidth(0.1),
        },
        children: [minutesRow, secondsRow, steeringRow, turnsRow],
      ),
    );

    List<Widget> draggableItems = [draggableLogo, spaceSmall, headerTile, spaceBig, textField, table];

    return DraggableScrollableSheet(
      initialChildSize: _newReceipt ? _maxChildSize : _minChildSize,
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
            itemCount: draggableItems.length,
            itemBuilder: (BuildContext context, int index) {
              return draggableItems[index];
            },
          ),
        );
      },
    );
  }
}
