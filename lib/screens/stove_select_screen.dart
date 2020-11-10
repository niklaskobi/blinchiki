import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:blinchiki_app/widgets/receipt_icons_block_widget.dart';
import 'package:blinchiki_app/widgets/steering_scrollable_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blinchiki_app/data/constants.dart';

class StoveSelectScreen extends StatefulWidget {
  final int activeIndex;

  StoveSelectScreen({@required this.activeIndex});
  @override
  _StoveSelectScreen createState() => _StoveSelectScreen();
}

class _StoveSelectScreen extends State<StoveSelectScreen> {
  IconDataSpec iconDataSpec = IconDataSpec();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.1, bottom: screenHeight * 0.05),
            child: CircleAvatar(
              child: Consumer<ReceiptList>(builder: (context, receiptList, child) {
                return SvgPicture.asset(
                  iconDataSpec.getMainStoveIcon(receiptList.getReceiptByIndex(widget.activeIndex).steeringSetting),
                  //fit: BoxFit.scaleDown,
                  width: screenHeight * 0.08,
                );
              }),
              radius: screenHeight * 0.08,
              backgroundColor: kReceiptCardDescription,
            ),
          ),
          Expanded(child: SteeringScrollableBlockWidget(receiptIndex: widget.activeIndex)),
        ],
      ),
    );
  }
}
