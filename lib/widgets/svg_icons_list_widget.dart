import 'package:blinchiki_app/data/constants.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:blinchiki_app/models/icon_spec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class SvgIconsListWidget extends StatelessWidget {
  /// Sizes - basic
  static double _containerHeight = 100.0;
  static double _iconContainerHeight = 70.0;
  static double _containerMargin = 3.0;
  static double _circularBorder = 10.0;

  final int receiptIndex;
  final int level;

  SvgIconsListWidget({@required this.receiptIndex, @required this.level});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final IconDataSpec iconDataSpec = IconDataSpec();
    final list = iconDataSpec.getStoveIconsList(level);

    Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(receiptIndex);

    void setIcon(int newIconId) {
      Provider.of<ReceiptList>(context, listen: false).setSteeringIcon(receiptIndex, level, newIconId);
    }

    /// write receipt list to the device's storage
    void writeReceiptsToDevice() async {
      await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
    }

    void selectSteering(int index) {}

    Widget iconContainer(int index) {
      Color _bdColor = receipt.steeringSetting.isIndexActive(level, index)
          ? kIconSelectionIconBgActive
          : kIconSelectionIconBgNonActive;
      return GestureDetector(
        onTap: () {
          setIcon(index);
          writeReceiptsToDevice();
        },
        child: Container(
          height: _iconContainerHeight,
          width: _iconContainerHeight,
          decoration: BoxDecoration(color: _bdColor, borderRadius: BorderRadius.circular(_circularBorder)),
          margin: EdgeInsets.all(_containerMargin),
          child: Center(
            child: Container(
              height: _iconContainerHeight / 1.7,
              width: _iconContainerHeight / 1.7,
              child: SvgPicture.asset(
                list[index],
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      height: _containerHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Center(child: iconContainer(index));
        },
        itemCount: list.length,
      ),
    );
  }
}
