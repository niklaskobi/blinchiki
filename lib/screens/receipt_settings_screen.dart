import 'dart:convert';
import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
import 'package:blinchiki_app/screens/icon_select_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:provider/provider.dart';
import 'package:blinchiki_app/functions/common.dart';
import 'package:blinchiki_app/widgets/table_row.dart';
import 'package:blinchiki_app/widgets/times_column_widget.dart';
import 'package:blinchiki_app/data/constants.dart';

class ReceiptSettingsScreen extends StatefulWidget {
  final int receiptIndex;
  final bool newReceipt;

  ReceiptSettingsScreen({this.receiptIndex, this.newReceipt});

  @override
  _ReceiptSettingsScreenState createState() => _ReceiptSettingsScreenState();
}

class _ReceiptSettingsScreenState extends State<ReceiptSettingsScreen> {
  /// statics ----------------------------------------------
  static double _maxChildSize = 0.6;
  static double _minChildSize = 0.15;
  final myController = TextEditingController();

  /// vars -------------------------------------------------
  int _timerIndex = 0;
  Map saveDurationsMap = new Map<int, MyDuration>();

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
    IconDataSpec iconDataSpec = IconDataSpec();

    Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(index);
    myController.text = receipt.name;

    /// write receipt list to the device's storage
    void writeReceiptsToDevice() async {
      await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
    }

    /// returns the timer index if turns counter is greater than 1
    String getTimerIndexStr() {
      int durations = receipt.durations.length;
      if (durations > 1)
        return '${_timerIndex + 1}.';
      else
        return '';
    }

    /// increment the turns index when pressing on the timer icon
    void timerOnTap() {
      setState(() {
        if (receipt.durations.length > 1) {
          _timerIndex = rotatingIncrement(this._timerIndex, 0, receipt.durations.length - 1);
        }
      });
    }

    void updateAmountOfTurns(int value) {
      // set timer index to max turns value
      _timerIndex = _timerIndex > value - 1 ? _timerIndex = value.toInt() : _timerIndex;
      int durations = receipt.durations.length;
      // increment turns amount
      if (value + 1 > durations) {
        // try to use previous value
        MyDuration newDuration =
            saveDurationsMap.containsKey(value) ? saveDurationsMap[value] : MyDuration(minutes: 0, seconds: 0);
        //TODO: not sure whether i need a loop here, or a single increment is enough
        Provider.of<ReceiptList>(context, listen: false).addNewDuration(index, newDuration);
        writeReceiptsToDevice();
      } else if (value + 1 < durations) {
        // save previous value
        saveDurationsMap[value + 1] = receipt.getDuration(value + 1);
        print(saveDurationsMap.toString());
        receipt.removeDuration();
        writeReceiptsToDevice();
      }
    }

    /// whether turns icon must be shown or not
    bool isTurnsAvailable = receipt.durations.length > 1;

    Widget sliderWidget(
        {double rowHeight,
        double sliderValue,
        int divisions,
        double min,
        double max,
        Function sliderFunction,
        Function onChangeEndFunction}) {
      return SliderTheme(
        data: SliderTheme.of(context),
        child: Container(
          height: rowHeight,
          child: Align(
            alignment: Alignment.center,
            child: Slider(
              value: sliderValue,
              divisions: divisions,
              min: min,
              max: max,
              onChanged: (double newValue) {
                sliderFunction(newValue);
              },
              onChangeEnd: (double newValue) {
                onChangeEndFunction();
              },
            ),
          ),
        ),
      );
    }

    /// turns row ----------------------------------------------------------------------------------------------------
    TableRow turnsRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '',
      text2: '',
      text3: '${receipt.durations.length - 1}',
      iconData: kTurnsIcon,
      index: index,
      iconFunction: null,
      context: context,
      widget: sliderWidget(
          rowHeight: _rowHeight,
          divisions: ReceiptData.maxDurationAmount - 1,
          min: 0.0,
          max: ReceiptData.maxDurationAmount.toDouble() - 1,
          sliderValue: receipt.durations.length.toDouble() - 1,
          sliderFunction: (double value) {
            setState(() {
              updateAmountOfTurns(value.toInt());
            });
          },
          onChangeEndFunction: () {}),
    );

    /// steering row --------------------------------------------------------------------------------------------------
    TableRow steeringRow = MyTableRow.createTableRow(
        rowHeight: _rowHeight,
        text1: '',
        text2: '',
        text3: '${receipt.steeringSetting.value}',
        iconData: kFireIcon,
        index: index,
        iconFunction: null,
        context: context,
        widget: sliderWidget(
            rowHeight: _rowHeight,
            divisions: 12,
            min: 0.0,
            max: 60.0,
            sliderValue: receipt.steeringSetting.value,
            sliderFunction: (double newValue) {
              setState(() {
                Provider.of<ReceiptList>(context, listen: false).setSteering(index, newValue);
              });
            },
            onChangeEndFunction: writeReceiptsToDevice));

    /// minutes row ---------------------------------------------------------------------------------------------------
    TableRow minutesRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '${getTimerIndexStr()}',
      text2: '\'',
      text3: '${receipt.getMinutes(_timerIndex)} \'',
      iconData: kTimerIcon,
      index: index,
      iconFunction: timerOnTap,
      context: context,
      widget: sliderWidget(
          rowHeight: _rowHeight,
          divisions: 30,
          min: 0.0,
          max: 30.0,
          sliderValue: receipt.getMinutes(_timerIndex).toDouble(),
          sliderFunction: (double newValue) {
            setState(() {
              Provider.of<ReceiptList>(context, listen: false).setMinutes(index, _timerIndex, newValue.round());
            });
          },
          onChangeEndFunction: writeReceiptsToDevice),
    );

    /// seconds row ---------------------------------------------------------------------------------------------------
    TableRow secondsRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '${getTimerIndexStr()}',
      text2: '\'\'',
      text3: '${receipt.getSeconds(_timerIndex)} \'\'',
      iconData: kTimerIcon,
      index: index,
      iconFunction: timerOnTap,
      context: context,
      widget: sliderWidget(
          rowHeight: _rowHeight,
          divisions: 11,
          min: 0.0,
          max: 55.0,
          sliderValue: receipt.getSeconds(_timerIndex).toDouble(),
          sliderFunction: (double newValue) {
            setState(() {
              Provider.of<ReceiptList>(context, listen: false).setSeconds(index, _timerIndex, newValue.round());
            });
          },
          onChangeEndFunction: writeReceiptsToDevice),
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
            icon: Icon(kTimerIcon),
            onPressed: timerOnTap,
          ),
          TimesColumnWidget(durations: receipt.durations, activeIndex: this._timerIndex),
          SizedBox(width: screenWidth * 0.03),
          Icon(kFireIcon),
          Text('${receipt.steeringSetting.value}'),
          if (isTurnsAvailable) SizedBox(width: screenWidth * 0.03),
          if (isTurnsAvailable) Icon(kTurnsIcon),
          if (isTurnsAvailable) Text('${receipt.durations.length - 1}'),
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
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Container(
        //padding: EdgeInsets.only(left: screenWidth * 0.15, right: screenWidth * 0.15),
        child: TextFormField(
          initialValue: receipt.name,
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
      ),
    );

    /// seconds row ---------------------------------------------------------------------------------------------------
    TableRow textFieldRow = MyTableRow.createTableRow(
      rowHeight: _rowHeight,
      text1: '',
      text2: '',
      text3: '',
      iconData: iconDataSpec.getIconData(receipt.iconId),
      index: index,
      iconFunction: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => IconSelectScreen(activeReceiptIndex: index)));
      },
      context: context,
      widget: textField,
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
        children: [textFieldRow, minutesRow, secondsRow, steeringRow, turnsRow],
      ),
    );

    List<Widget> draggableItems = [draggableLogo, headerTile, spaceBig, table];

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
