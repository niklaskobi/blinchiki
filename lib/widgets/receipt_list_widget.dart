import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/screens/timer_screen.dart';
import 'package:blinchiki_app/widgets/receipt_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptList>(builder: (context, receiptList, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final receipt = receiptList.unmodifiableReceiptList[index];
          return ReceiptTileWidget(
            iconData: IconDataSpec.getIconData(receipt.iconId),
            receiptTitle: receipt.name,
            shortPressCallback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerScreen(index: index),
                  ));
            },
            longPressCallback: () {
              print('checkboxCallback');
            },
          );
        },
        itemCount: receiptList.receiptCount,
      );
    });
  }
}
