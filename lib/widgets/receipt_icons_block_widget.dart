import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'icons_list_widget.dart';
import 'icon_selection_separator.dart';
import 'package:provider/provider.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'dart:convert';

class ReceiptIconBlockWidget extends StatefulWidget {
  final int activeIndex;

  ReceiptIconBlockWidget({@required this.activeIndex});

  @override
  _ReceiptIconBlockWidgetState createState() => _ReceiptIconBlockWidgetState();
}

class _ReceiptIconBlockWidgetState extends State<ReceiptIconBlockWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    IconDataSpec iconDataSpec = IconDataSpec();

    /// write receipt list to the device's storage
    void writeReceiptsToDevice() async {
      await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()), FileIO().getReceiptsFile());
    }

    void onTap(int newIconId) {
      Provider.of<ReceiptList>(context, listen: false).setIconId(widget.activeIndex, newIconId);
      writeReceiptsToDevice();
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final iconGroup = iconDataSpec.getReceiptIconGroup(index);
        final iconList = iconDataSpec.getReceiptIconsForGroup(index);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getSeparator(iconGroup.iconData, screenHeight, screenWidth),
            IconsListWidget(list: iconList, activeIndex: widget.activeIndex, onTapFunction: onTap),
          ],
        );
      },
      itemCount: iconDataSpec.getReceiptIconGroupCount(),
    );
  }
}
