import 'package:blinchiki_app/models/default_steering_list.dart';
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
import 'package:blinchiki_app/functions/common.dart';

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
    DefaultSteeringList defaultSteeringList = DefaultSteeringList();

    /// write receipt list to the device's storage
    void writeReceiptsToDevice() async {
      await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()), FileIO().getReceiptsFile());
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

    /// if min and max are nulls, it means that the function is called from the
    /// ui and not from validateMin or validateMax. In that case fetch min and max
    /// from the receipt.
    bool validateStep(double min, double max, String input) {
      if (min == null && max == null) {
        min = receipt.steeringSetting.min;
        max = receipt.steeringSetting.max;
      }
      print("validate step, min = $min, max = $max, step = $input");
      if (!isNumeric(input)) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Oh oh!'),
                  content: Text("Invalid number!"),
                ));
        return false;
      }
      double diff = max - min;
      if (diff / 2 >= double.parse(input))
        return true;
      else {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Duh!'),
                  content: Text('Step is too small!'),
                ));
        return false;
      }
    }

    bool validateMin(String input) {
      if (!isNumeric(input)) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Oh oh!'),
                  content: Text("Invalid number!"),
                ));
        return false;
      }
      double min = double.parse(input);
      if (min >= receipt.steeringSetting.max) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Duh!'),
                  content: Text('Min must be smaller than Max!'),
                ));
        return false;
      }
      if (!validateStep(min, receipt.steeringSetting.max, receipt.steeringSetting.step.toString())) return false;
      return min < receipt.steeringSetting.max;
    }

    bool validateMax(String input) {
      if (!isNumeric(input)) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Oh oh!'),
                  content: Text("Invalid number!"),
                ));
        return false;
      }
      double max = double.parse(input);
      if (double.parse(input) <= receipt.steeringSetting.min) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Duh!'),
                  content: Text('Max must be greater than Min!'),
                ));
        return false;
      }
      if (!validateStep(receipt.steeringSetting.min, max, receipt.steeringSetting.step.toString())) return false;
      return max > receipt.steeringSetting.min;
    }

    void updateStep(String input) {
      receipt.steeringSetting.step = double.parse(input);
      writeReceiptsToDevice();
    }

    void updateMin(String input) {
      double min = double.parse(input);
      if (receipt.steeringSetting.value < min) receipt.steeringSetting.value = min;
      receipt.steeringSetting.min = min;
      writeReceiptsToDevice();
    }

    void updateMax(String input) {
      double max = double.parse(input);
      if (receipt.steeringSetting.value > max) receipt.steeringSetting.value = max;
      receipt.steeringSetting.max = double.parse(input);
      writeReceiptsToDevice();
    }

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
          getNumberField(
              defaultSteeringList
                  .getSetting(Provider.of<ReceiptList>(context, listen: false)
                      .getReceiptByIndex(widget.activeIndex)
                      .steeringSetting
                      .firstStoveIconId)
                  .min,
              "Min",
              screenHeight * 0.02,
              validateMin,
              updateMin),
          getNumberField(
              defaultSteeringList
                  .getSetting(Provider.of<ReceiptList>(context, listen: false)
                      .getReceiptByIndex(widget.activeIndex)
                      .steeringSetting
                      .firstStoveIconId)
                  .max,
              "Max",
              screenHeight * 0.02,
              validateMax,
              updateMax),
          getNumberField(
              defaultSteeringList
                  .getSetting(Provider.of<ReceiptList>(context, listen: false)
                      .getReceiptByIndex(widget.activeIndex)
                      .steeringSetting
                      .firstStoveIconId)
                  .step,
              "Step",
              screenHeight * 0.02,
              validateStep,
              updateStep),
        ],
      ),
    );
  }
}
