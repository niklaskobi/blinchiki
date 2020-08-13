import 'package:flutter/material.dart';

class ReceiptTileWidget extends StatelessWidget {
  final String receiptTitle;
  final Function shortPressCallback;
  final Function longPressCallback;
  final IconData iconData;

  ReceiptTileWidget({this.receiptTitle, this.shortPressCallback, this.longPressCallback, this.iconData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPressCallback,
      onTap: shortPressCallback,
      leading: CircleAvatar(
        child: Icon(
          iconData,
          size: 25,
          color: Colors.lightBlueAccent,
        ),
      ),
      title: Text(
        receiptTitle,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text('Subtitle'),
      trailing: Text('Trailing'),
    );
  }
}
