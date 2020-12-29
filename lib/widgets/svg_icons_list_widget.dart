import 'package:blinchiki_app/data/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconsListWidget extends StatelessWidget {
  /// Sizes - basic
  static double _containerHeight = 100.0;
  static double _iconContainerHeight = 70.0;
  static double _containerMargin = 3.0;
  static double _circularBorder = 10.0;

  final int receiptIndex;
  final Function onTap;
  final Function isActive;
  final List<String> iconPathList;
  final double svgSizeFactor;

  SvgIconsListWidget({
    @required this.receiptIndex,
    @required this.iconPathList,
    @required this.isActive,
    @required this.onTap,
    @required this.svgSizeFactor,
  });

  @override
  Widget build(BuildContext context) {
    //Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(receiptIndex);

    Widget iconContainer(int index) {
      Color _bdColor = isActive(index) ? kIconSelectionIconBgActive : kIconSelectionIconBgNonActive;
      return GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
          height: _iconContainerHeight,
          width: _iconContainerHeight,
          decoration: BoxDecoration(color: _bdColor, borderRadius: BorderRadius.circular(_circularBorder)),
          margin: EdgeInsets.all(_containerMargin),
          child: Center(
            child: Container(
              height: _iconContainerHeight * svgSizeFactor,
              width: _iconContainerHeight * svgSizeFactor,
              child: SvgPicture.asset(iconPathList[index]),
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
        itemCount: iconPathList.length,
      ),
    );
  }
}
