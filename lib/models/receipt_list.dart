import 'dart:convert';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:flutter/foundation.dart';
import 'receipt_data.dart';
import 'dart:collection';

//TODO: refactor ReceiptList and ReceiptData into 1
class ReceiptList extends ChangeNotifier {
  List<Receipt> _list;

  ReceiptList() {
    print("constructor");
    this._list = ReceiptData.defaultReceiptList;
    print("Ready");
  }

  List<Receipt> get() => this._list;

  /// parse Receipt list
  static List<Receipt> receiptsFromJson(String json) =>
      (jsonDecode(json) as List).map((i) => Receipt.fromJson(i)).toList();

  /// deserialization
  void initFromJson(Map<String, dynamic> json) => this._list = receiptsFromJson(json['receiptList']);

  /// add receipt
  void addReceipt(Receipt r) {
    _list.add(r);
    notifyListeners();
  }

  /// update item
  void updateReceiptOnIndex(int index, Receipt r) {
    this._list[index] = r;
  }

  /// getter unmodifiable
  UnmodifiableListView<Receipt> get unmodifiableReceiptList {
    return UnmodifiableListView(this._list);
  }

  /// getter by index
  Receipt getReceiptByIndex(int index) {
    print("im in");
    return _list[index];
  }

  /// get active receipt name
  String getName(int index) {
    return this._list[index].name;
  }

  /// set turns on index
  void setTurns(int index, int t) {
    this._list[index].setTurns(t);
    notifyListeners();
  }

  void initReceiptListFromJson(String json) {
    initFromJson(jsonDecode(json));
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {'receiptList': jsonEncode(this._list)};

  /// get count of all receipts
  int get receiptCount => _list.length;
}
