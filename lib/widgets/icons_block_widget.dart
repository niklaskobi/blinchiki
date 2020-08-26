import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'icons_list_widget.dart';

class IconsBlockWidget extends StatefulWidget {
  final int activeIndex;

  IconsBlockWidget({@required this.activeIndex});

  @override
  _IconsBlockWidgetState createState() => _IconsBlockWidgetState();
}

class _IconsBlockWidgetState extends State<IconsBlockWidget> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    IconDataSpec iconDataSpec = IconDataSpec();
    Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(widget.activeIndex);

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
        final iconGroup = iconDataSpec.getIconGroup(index);
        final iconList = iconDataSpec.getIconsForGroup(index);
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
            //Text('Dummy Text', style: TextStyle(color: Colors.black)),
          ],
        );
      },
      itemCount: iconDataSpec.getIconGroupCount(),
    );
  }
}
