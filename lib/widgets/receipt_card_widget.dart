import 'package:blinchiki_app/models/receipt.dart';
import 'package:flutter/material.dart';
import 'package:blinchiki_app/data/constants.dart';
import 'dart:ui';

class ReceiptCardWidget extends StatelessWidget {
  final Receipt receipt;
  final Function shortPressCallback;
  final Function longPressCallback;
  final IconData iconData;

  /// Sizes - basic
  static double _containerHeight = 95.0;
  static double _containerMargin = 4.0;
  static double _circularBorder = 10.0;

  /// Sizes - icon
  static double _iconTileWidth = 60.0;
  static double _iconTileIconSize = _iconTileWidth * 0.5;
  static double _iconTileMarginVertical = 3.0;
  static double _iconTileMarginHorizontal = 10.0;

  /// Sizes - content
  static double _contentTitleSize = _containerHeight * 0.2;
  static double _contentIconSize = _containerHeight * 0.15;
  static double _contentIconTextSize = _containerHeight * 0.15;
  static double _contentInbetweenSize = _containerHeight * 0.1;

  ReceiptCardWidget({this.receipt, this.shortPressCallback, this.longPressCallback, this.iconData});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 5,
      disabledElevation: 5,
      focusElevation: 5,
      highlightElevation: 5,
      onLongPress: longPressCallback,
      onPressed: shortPressCallback,
      child: Container(
        decoration: BoxDecoration(color: kReceiptCardBackground, borderRadius: BorderRadius.circular(_circularBorder)),
        height: _containerHeight,
        margin: EdgeInsets.all(_containerMargin),
        //color: Colors.grey,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: _iconTileMarginVertical, horizontal: _iconTileMarginHorizontal),
              width: _iconTileWidth,
              height: _iconTileWidth,
              decoration: BoxDecoration(
                  color: kReceiptCardIconTileBackground, borderRadius: BorderRadius.circular(_circularBorder)),
              child: Icon(
                iconData,
                size: _iconTileIconSize,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: _iconTileMarginVertical, horizontal: _iconTileMarginHorizontal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(receipt.name,
                      style: TextStyle(
                          color: kReceiptCardTitle, fontWeight: FontWeight.w700, fontSize: _contentTitleSize)),
                  //Text('Description', style: TextStyle(color: kReceiptCardDescription)),
                  Row(
                    children: <Widget>[
                      Icon(kTimerIcon, size: _contentIconSize),
                      Text(receipt.getOverallSeconds(0).toString(),
                          style: TextStyle(color: Colors.black, fontSize: _contentIconTextSize)),
                      SizedBox(width: _contentInbetweenSize),
                      if (receipt.isWarmedUp) Icon(kWarmedUpIcon, size: _contentIconSize)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
