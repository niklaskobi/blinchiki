import 'dart:convert';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:flutter/foundation.dart';
import 'receipt_data.dart';
import 'dart:collection';

//TODO: refactor ReceiptList and ReceiptData into 1
class ReceiptList extends ChangeNotifier {
  List<Receipt> _list;

  ReceiptList() {
    this._list = ReceiptData.defaultReceiptList;
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
    return _list[index];
  }

  /// get active receipt name
  String getName(int index) {
    return this._list[index].name;
  }

  /// set turns on index
  void setTurns(int index, int t) {
    this._list[index].setTurns(t);
  }

  /// set steering on index
  void setSteering(int index, double s) {
    this._list[index].steeringSetting.value = s;
  }

  /// set seconds on index
  void setSeconds(int index, int timerIndex, int s) {
    this._list[index].setSeconds(timerIndex, s);
    notifyListeners();
  }

  /// set minutes on index
  void setMinutes(int index, int timerIndex, int s) {
    this._list[index].setMinutes(timerIndex, s);
    notifyListeners();
  }

  /// set name on index
  void setName(int index, String name) {
    this._list[index].name = name;
    notifyListeners();
  }

  /// create new receipt and return its index
  int createReceipt() {
    Receipt newReceipt = Receipt.copy(ReceiptData.defaultReceipt);
    this._list.add(newReceipt);
    return this._list.indexOf(newReceipt);
  }

  void initReceiptListFromJson(String json) {
    print(jsonDecode(json));
    initFromJson(jsonDecode(json));
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    print("!!!!!!! toJSon");
    return {'receiptList': jsonEncode(this._list)};
  }

  /// get count of all receipts
  int get receiptCount => _list.length;
}
