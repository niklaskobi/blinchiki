import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/screens/timer_screen.dart';
import 'package:blinchiki_app/widgets/receipt_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:blinchiki_app/data/constants.dart';

class ReceiptListWidget extends StatefulWidget {
  @override
  _ReceiptListWidgetState createState() => _ReceiptListWidgetState();
}

class _ReceiptListWidgetState extends State<ReceiptListWidget> {
  Receipt saveReceipt;
  int saveIndex;
  IconDataSpec iconDataSpec = IconDataSpec();

  @override
  Widget build(BuildContext context) {
    SnackBar getSnackBar(String itemName) {
      return SnackBar(
        backgroundColor: Colors.grey,
        content: Text('$itemName removed!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            Provider.of<ReceiptList>(context, listen: false).insertReceipt(saveIndex, saveReceipt.copy());
          },
        ),
      );
    }

    return Consumer<ReceiptList>(builder: (context, receiptList, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final receipt = receiptList.getReceiptByIndex(index);
          return Dismissible(
            key: Key(receipt.name),
            onDismissed: (direction) {
              print('is dismissed');
            },
            child: Slidable(
              dismissal: SlidableDismissal(
                child: SlidableDrawerDismissal(),
                onDismissed: (actionType) {
                  saveIndex = index;
                  saveReceipt = receipt.copy();
                  setState(() {
                    Provider.of<ReceiptList>(context, listen: false).deleteReceipt(index);
                  });
                  Scaffold.of(context).showSnackBar(getSnackBar(receipt.name));
                },
              ),
              key: Key(receipt.name),
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                color: kBackgroundWhite,
                child: ReceiptCardWidget(
                  iconData: iconDataSpec.getIconData(receipt.iconId),
                  receipt: receipt,
                  shortPressCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerScreen(receiptIndex: index, newReceipt: false),
                        ));
                  },
                ),
              ),
              /*
              actions: <Widget>[
                IconSlideAction(
                    caption: 'Archive',
                    color: Colors.blue,
                    icon: Icons.archive,
                    onTap: () => print('Archive') //_showSnackBar('Archive'),
                    ),
                IconSlideAction(
                    caption: 'Share',
                    color: Colors.indigo,
                    icon: Icons.share,
                    onTap: () => print('Share') //_showSnackBar('Share'),
                    ),
              ],
               */
              secondaryActions: <Widget>[
                /*
                IconSlideAction(
                    caption: 'More',
                    color: Colors.black45,
                    icon: Icons.more_horiz,
                    onTap: () => print('More') //_showSnackBar('More'),
                    ),
                 */
                IconSlideAction(
                    caption: 'Delete',
                    color: kBackgroundWhite,
                    icon: Icons.delete,
                    onTap: () => {
                          saveIndex = index,
                          saveReceipt = receipt.copy(),
                          setState(() {
                            Provider.of<ReceiptList>(context, listen: false).deleteReceipt(index);
                          }),
                          Scaffold.of(context).showSnackBar(getSnackBar(receipt.name))
                        }),
              ],
            ),
          );
        },
        itemCount: Provider.of<ReceiptList>(context, listen: false).receiptCount,
      );
    });
  }
}
