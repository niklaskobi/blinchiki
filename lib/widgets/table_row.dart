import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blinchiki_app/models/receipt_list.dart';

class MyTableRow {
  static TableRow createTableRow(
    double rowHeight,
    String text1,
    String text2,
    String text3,
    IconData iconData,
    int index,
    int divisions,
    double min,
    double max,
    double sliderValue,
    Function iconFunction,
    Function sliderFunction,
    BuildContext context,
  ) {
    return TableRow(
      children: <Widget>[
        Container(height: rowHeight, child: Align(alignment: Alignment.center, child: Text(text1))),
        Container(
            height: rowHeight,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: IconButton(
                  icon: Icon(iconData),
                  onPressed: () {
                    iconFunction();
                  },
                ),
              ),
            )),
        Container(height: rowHeight, child: Align(alignment: Alignment.center, child: Text(text2))),
        SliderTheme(
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
              ),
            ),
          ),
        ),
        Container(height: rowHeight, child: Align(alignment: Alignment.center, child: Text(text3))),
      ],
    );
  }
}
