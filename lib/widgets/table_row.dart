import 'package:flutter/material.dart';

class MyTableRow {
  static TableRow createTableRow({
    double rowHeight,
    String text,
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
              child: myIconButtonWithCircle(iconData, iconFunction, rowHeight * 0.75),
            )),
        widget,
        Container(height: rowHeight, child: Align(alignment: Alignment.center, child: Text(text))),
      ],
    );
  }

  static Widget myIconButton(IconData iconData, Function onPressed, width) {
    return Container(
      child: IconButton(icon: Icon(iconData, color: Colors.black), onPressed: onPressed),
    );
  }

  static Widget myIconButtonWithCircle(IconData iconData, Function onPressed, width) {
    return Container(
      width: width,
      child: Material(
        shape: CircleBorder(),
        color: Colors.white,
        elevation: onPressed == null ? 0 : 1.5,
        child: Ink(
          //width: 50,
          //height: 50,
          //decoration: const ShapeDecoration(shape: CircleBorder(), color: Colors.lightBlueAccent),
          child: IconButton(
            icon: Icon(iconData, color: Colors.black),
            color: Colors.black,
            onPressed: onPressed,
            iconSize: 20,
          ),
        ),
      ),
    );
  }
}
