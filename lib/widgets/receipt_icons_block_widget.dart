import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'icons_list_widget.dart';

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

    Container separator() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: screenHeight * 0.002,
        width: screenWidth * 0.4,
        decoration:
            BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10.0)), //TODO: take background color
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final iconGroup = iconDataSpec.getReceiptIconGroup(index);
        final iconList = iconDataSpec.getReceiptIconsForGroup(index);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                separator(),
                Icon(iconGroup.iconData),
                separator(),
              ],
            ),
            IconsListWidget(list: iconList, activeIndex: widget.activeIndex),
          ],
        );
      },
      itemCount: iconDataSpec.getReceiptIconGroupCount(),
    );
  }
}
