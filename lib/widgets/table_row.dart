import 'package:flutter/material.dart';

class MyTableRow {
  static TableRow createTableRow({
    double rowHeight,
    String text1,
    String text2,
    String text3,
    IconData iconData,
    int index,
    Function iconFunction,
    BuildContext context,
    Widget widget,
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
        widget,
        Container(height: rowHeight, child: Align(alignment: Alignment.center, child: Text(text3))),
      ],
    );
  }
}
