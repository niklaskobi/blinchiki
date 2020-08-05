import 'package:flutter/material.dart';

class MyTableRow {
  static TableRow createTableRow({
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
    Function onChangeEndFunction,
    BuildContext context,
  }) {
    return TableRow(
      children: <Widget>[
        Container(
            height: rowHeight,
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  text1,
                  style: TextStyle(fontSize: 13),
                ))),
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
                onChangeEnd: (double newValue) {
                  onChangeEndFunction();
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
