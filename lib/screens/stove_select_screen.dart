import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/widgets/icon_selection_separator.dart';
import 'package:blinchiki_app/widgets/number_enter_field.dart';
import 'package:blinchiki_app/widgets/svg_icons_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blinchiki_app/data/constants.dart';
import 'dart:convert';
import 'package:blinchiki_app/data/fileIO.dart';

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

    Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(widget.activeIndex);

    /// write receipt list to the device's storage
    void writeReceiptsToDevice() async {
      await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
    }

    void stoveIconSelection(int newIconId) {
      Provider.of<ReceiptList>(context, listen: false).setSteeringIcon(widget.activeIndex, 0, newIconId);
      writeReceiptsToDevice();
    }

    void unitIconSelection(int newUnitIconId) {
      Provider.of<ReceiptList>(context, listen: false).setUnitId(widget.activeIndex, newUnitIconId);
      writeReceiptsToDevice();
    }

    bool isStoveIconActive(int index) => receipt.steeringSetting.isIndexActive(0, index);
    bool isUnitIconActive(int index) => receipt.steeringSetting.unitId == index;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.05, bottom: screenHeight * 0.05),
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
          getSeparator(Icons.settings, screenHeight, screenWidth),
          //Flexible(child: SteeringScrollableBlockWidget(receiptIndex: widget.activeIndex)),
          SvgIconsListWidget(
            receiptIndex: widget.activeIndex,
            iconPathList: iconDataSpec.getStoveIconsList(0),
            isActive: isStoveIconActive,
            onTap: stoveIconSelection,
            svgSizeFactor: 0.6,
          ),
          getSeparator(Icons.translate, screenHeight, screenWidth), // Units
          SvgIconsListWidget(
            receiptIndex: widget.activeIndex,
            iconPathList: iconDataSpec.getUnitPathsList(),
            isActive: isUnitIconActive,
            onTap: unitIconSelection,
            svgSizeFactor: 0.35,
          ),
          getSeparator(Icons.tune, screenHeight, screenWidth),
          getNumberField(receipt.steeringSetting.min, "Min", screenHeight * 0.02),
          getNumberField(receipt.steeringSetting.max, "Max", screenHeight * 0.02),
          getNumberField(receipt.steeringSetting.step, "Step", screenHeight * 0.02),
        ],
      ),
    );
  }
}
