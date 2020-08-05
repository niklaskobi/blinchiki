import 'dart:convert';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:provider/provider.dart';
import 'package:blinchiki_app/functions/common.dart';
import 'package:blinchiki_app/widgets/table_row.dart';
import 'package:blinchiki_app/widgets/times_column_widget.dart';

class ReceiptSettingsScreen extends StatefulWidget {
  final int receiptIndex;
  final bool newReceipt;

  ReceiptSettingsScreen({this.receiptIndex, this.newReceipt});

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
  int _timerIndex = 0;

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

    myController.text = Provider.of<ReceiptList>(context).getReceiptByIndex(index).name;

    /// write receipt list to the device's storage
    void writeReceiptsToDevice() async {
      await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
    }

    /// returns the timer index if turns counter is greater than 1
    String getTimerIndexStr() {
      int durations = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length;
      if (durations > 1)
        return '${_timerIndex + 1}.';
      else
        return '';
    }

    /// increment the turns index when pressing on the timer icon
    void timerOnTap() {
      print(Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations);
      setState(() {
        if (Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length > 1) {
          _timerIndex = rotatingIncrement(this._timerIndex, 0,
              Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length - 1);
        }
      });
    }

    void updateAmountOfTurns(int value) {
      // set timer index to max turns value
      _timerIndex = _timerIndex > value - 1 ? _timerIndex = value.toInt() : _timerIndex;
      int durations = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length;
      // increment turns amount
      if (value + 1 > durations) {
        //TODO: not sure whether i need a loop here, or a single increment is enough
        Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).addNewDuration();
        writeReceiptsToDevice();
      } else if (value + 1 < durations) {
        Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).removeDuration();
        writeReceiptsToDevice();
        /*
        for (var i = 1; i < durations - value; i++) {
          Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).removeDuration();
        }
         */
      }
    }

    /// whether turns icon must be shown or not
    bool isTurnsAvailable =
        Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length > 1;

    /// turns row ----------------------------------------------------------------------------------------------------
    TableRow turnsRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '',
      text2: '',
      text3: '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length - 1}',
      iconData: _turnsIcon,
      index: index,
      divisions: ReceiptData.maxDurationAmount - 1,
      min: 0.0,
      max: ReceiptData.maxDurationAmount.toDouble() - 1,
      sliderValue:
          Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length.toDouble() - 1,
      iconFunction: null,
      sliderFunction: (double value) {
        setState(() {
          updateAmountOfTurns(value.toInt());
        });
      },
      onChangeEndFunction: () {},
      context: context,
    );

    /// steering row --------------------------------------------------------------------------------------------------
    TableRow steeringRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '',
      text2: '',
      text3: '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).steeringSetting.value}',
      iconData: _fireIcon,
      index: index,
      divisions: 12,
      min: 0.0,
      max: 60.0,
      sliderValue: Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).steeringSetting.value,
      iconFunction: null,
      sliderFunction: (double newValue) {
        setState(() {
          Provider.of<ReceiptList>(context, listen: false).setSteering(index, newValue);
        });
      },
      onChangeEndFunction: writeReceiptsToDevice,
      context: context,
    );

    /// minutes row ---------------------------------------------------------------------------------------------------
    TableRow minutesRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '${getTimerIndexStr()}',
      text2: '\'',
      text3: '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getMinutes(_timerIndex)} \'',
      iconData: _timerIcon,
      index: index,
      divisions: 30,
      min: 0.0,
      max: 30.0,
      sliderValue:
          Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getMinutes(_timerIndex).toDouble(),
      iconFunction: timerOnTap,
      sliderFunction: (double newValue) {
        setState(() {
          Provider.of<ReceiptList>(context, listen: false).setMinutes(index, _timerIndex, newValue.round());
        });
      },
      onChangeEndFunction: writeReceiptsToDevice,
      context: context,
    );

    /// seconds row ---------------------------------------------------------------------------------------------------
    TableRow secondsRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '${getTimerIndexStr()}',
      text2: '\'\'',
      text3:
          '${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getSeconds(_timerIndex)} \'\'',
      iconData: _timerIcon,
      index: index,
      divisions: 11,
      min: 0.0,
      max: 55.0,
      sliderValue:
          Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).getSeconds(_timerIndex).toDouble(),
      iconFunction: timerOnTap,
      sliderFunction: (double newValue) {
        setState(() {
          Provider.of<ReceiptList>(context, listen: false).setSeconds(index, _timerIndex, newValue.round());
        });
      },
      onChangeEndFunction: writeReceiptsToDevice,
      context: context,
    );

    /// draggable logo ( - ) ------------------------------------------------------------------------------------------
    Widget draggableLogo = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          height: screenHeight * 0.003,
          width: screenWidth * 0.1,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)), //TODO: take background color
        ),
      ],
    );

    Widget spaceBig = SizedBox(height: screenHeight * 0.05);

    /// header --------------------------------------------------------------------------------------------------------
    Widget headerTile = Container(
      height: screenHeight * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(_timerIcon),
            onPressed: timerOnTap,
          ),
          TimesColumnWidget(
              durations: Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations,
              activeIndex: this._timerIndex),
          SizedBox(width: screenWidth * 0.03),
          Icon(_fireIcon),
          Text('${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).steeringSetting.value}'),
          if (isTurnsAvailable) SizedBox(width: screenWidth * 0.03),
          if (isTurnsAvailable) Icon(_turnsIcon),
          if (isTurnsAvailable)
            Text('${Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).durations.length - 1}'),
          SizedBox(width: screenWidth * 0.1),
          /*
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
                    await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
                  },
                ))),
          )
           */
        ],
      ),
    );

    /// text field ----------------------------------------------------------------------------------------------------
    Widget textField = Container(
      padding: EdgeInsets.only(left: screenWidth * 0.15, right: screenWidth * 0.15),
      child: TextFormField(
        initialValue: Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index).name,
        autofocus: false,
        textAlign: TextAlign.center,
        decoration: InputDecoration(hintText: "Enter receipt name"),
        onChanged: (newText) {},
        onSaved: (newText) {
          print('onSaved');
        },
        onFieldSubmitted: (newText) {
          setState(() {
            //update name through receipt_data and receiver
            Provider.of<ReceiptList>(context, listen: false).setName(index, newText);
            writeReceiptsToDevice();
          });
        },
      ),
    );

    /// table ---------------------------------------------------------------------------------------------------------
    Widget table = Container(
      padding: EdgeInsets.only(top: screenHeight * 0.03),
      child: Table(
        columnWidths: {
          0: FractionColumnWidth(0.03),
          1: FractionColumnWidth(0.12),
          2: FractionColumnWidth(0.02),
          3: FractionColumnWidth(0.68),
          4: FractionColumnWidth(0.15),
        },
        children: [minutesRow, secondsRow, steeringRow, turnsRow],
      ),
    );

    List<Widget> draggableItems = [draggableLogo, headerTile, spaceBig, textField, table];

    /// main widget ---------------------------------------------------------------------------------------------------
    return DraggableScrollableSheet(
      initialChildSize: widget.newReceipt ? _maxChildSize : _minChildSize,
      maxChildSize: _maxChildSize,
      minChildSize: _minChildSize,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.001, horizontal: screenWidth * 0.02),
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
