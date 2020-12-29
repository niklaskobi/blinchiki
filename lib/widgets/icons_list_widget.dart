import 'package:blinchiki_app/data/constants.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:blinchiki_app/models/icon_spec.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconsListWidget extends StatelessWidget {
  /// Sizes - basic
  static double _containerHeight = 100.0;
  static double _iconContainerHeight = 70.0;
  static double _iconSize = 30.0;
  static double _containerMargin = 3.0;
  static double _circularBorder = 10.0;

  final List<IconSpec> list;
  final int activeIndex;
  final Function onTapFunction;

  IconsListWidget({@required this.list, @required this.activeIndex, @required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(activeIndex);

    Widget iconContainer(IconSpec iconSpec) {
      Color _bdColor = iconSpec.id == receipt.iconId ? kIconSelectionIconBgActive : kIconSelectionIconBgNonActive;
      return GestureDetector(
        onTap: () {
          onTapFunction();
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
