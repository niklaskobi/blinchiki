import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/widgets/icons_block_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class IconSelectScreen extends StatefulWidget {
  final int activeReceiptIndex;

  IconSelectScreen({@required this.activeReceiptIndex});
  @override
  _IconSelectScreenState createState() => _IconSelectScreenState();
}

class _IconSelectScreenState extends State<IconSelectScreen> {
  IconDataSpec iconDataSpec = IconDataSpec();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    Receipt receipt = Provider.of<ReceiptList>(context, listen: true).getReceiptByIndex(widget.activeReceiptIndex);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.1, bottom: screenHeight * 0.05),
            child: CircleAvatar(
              child: Icon(
                iconDataSpec.getIconData(receipt.iconId),
                size: screenHeight * 0.07,
              ),
              radius: screenHeight * 0.08,
            ),
          ),
          Expanded(child: IconsBlockWidget(activeIndex: widget.activeReceiptIndex)),
        ],
      ),
    );
  }
}
