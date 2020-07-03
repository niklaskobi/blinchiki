import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
import 'package:blinchiki_app/screens/timer_screen.dart';
import 'package:blinchiki_app/widgets/receipt_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiptListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiptData>(builder: (context, receiptData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final receipt = receiptData.unmodifiableReceiptList[index];
          return ReceiptTileWidget(
            iconData: IconDataSpec.getIconData(receipt.iconId),
            receiptTitle: receipt.name,
            shortPressCallback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimerScreen(receipt: receipt),
                  ));
            },
            longPressCallback: () {
              print('checkboxCallback');
            },
          );
        },
        itemCount: receiptData.receiptList.receiptCount,
      );
    });
  }
}
