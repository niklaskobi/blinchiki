import 'dart:convert';

import 'package:blinchiki_app/models/receipt.dart';

class ReceiptList {
  List<Receipt> _list;

  ReceiptList(List<Receipt> l) {
    this._list = l;
  }

  List<Receipt> get() => this._list;

  /// parse Receipt list
  static List<Receipt> receiptsFromJson(String json) =>
      (jsonDecode(json) as List).map((i) => Receipt.fromJson(i)).toList();

  /// deserialization
  ReceiptList.fromJson(Map<String, dynamic> json) : this._list = receiptsFromJson(json['receiptList']);

  /// add receipt
  void addReceipt(Receipt r) {
    _list.add(r);
  }

  /// update item
  void updateReceipt(int index, Receipt r) {
    this._list[index] = r;
  }

  Map<String, dynamic> toJson() => {'receiptList': jsonEncode(this._list)};

  int get receiptCount => _list.length;
}
