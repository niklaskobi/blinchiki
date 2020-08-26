import 'package:blinchiki_app/data/constants.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:blinchiki_app/models/icon_spec.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class IconsListWidget extends StatelessWidget {
  /// Sizes - basic
  static double _containerHeight = 100.0;
  static double _iconContainerHeight = 70.0;
  static double _iconSize = 30.0;
  static double _containerMargin = 3.0;
  static double _circularBorder = 10.0;

  final List<IconSpec> list;
  final int activeIndex;

  IconsListWidget({@required this.list, @required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(activeIndex);

    void setIcon(int newIconId) {
      Provider.of<ReceiptList>(context, listen: false).setIconId(activeIndex, newIconId);
    }

    /// write receipt list to the device's storage
    void writeReceiptsToDevice() async {
      await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
    }

    Widget iconContainer(IconSpec iconSpec) {
      Color _bdColor = iconSpec.id == receipt.iconId ? kIconSelectionIconBgActive : kIconSelectionIconBgNonActive;
      return GestureDetector(
        onTap: () {
          setIcon(iconSpec.id);
          writeReceiptsToDevice();
        },
        child: Container(
          height: _iconContainerHeight,
          width: _iconContainerHeight,
          decoration: BoxDecoration(color: _bdColor, borderRadius: BorderRadius.circular(_circularBorder)),
          margin: EdgeInsets.all(_containerMargin),
          child: Icon(iconSpec.iconData, size: _iconSize),
        ),
      );
    }

    return Container(
      height: _containerHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final iconSpec = list[index];
          return Center(child: iconContainer(iconSpec));
        },
        itemCount: list.length,
      ),
    );
  }
}
