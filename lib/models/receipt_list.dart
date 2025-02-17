import 'dart:convert';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:flutter/foundation.dart';
import 'receipt_data.dart';
import 'dart:collection';

//TODO: refactor ReceiptList and ReceiptData into 1
class ReceiptList extends ChangeNotifier {
  List<Receipt> _list;

  ReceiptList() {
    this._list = ReceiptData.getDefaultReceiptList();
  }

  List<Receipt> get() => this._list;

  /// parse Receipt list
  static List<Receipt> receiptsFromJson(String json) =>
      (jsonDecode(json) as List).map((i) => Receipt.fromJson(i)).toList();

  /// deserialization
  void initFromJson(Map<String, dynamic> json) => this._list = receiptsFromJson(json['receiptList']);

  /// add receipt
  void addReceipt(Receipt r) async {
    _list.add(r);
    await FileIO().writeString(jsonEncode(toJson()), FileIO().getReceiptsFile());
    notifyListeners();
  }

  /// insert receipt
  void insertReceipt(int index, Receipt r) async {
    _list.insert(index, r);
    await FileIO().writeString(jsonEncode(toJson()), FileIO().getReceiptsFile());
    notifyListeners();
  }

  /// update item
  void updateReceiptOnIndex(int index, Receipt r) => this._list[index] = r;

  /// getter unmodifiable
  UnmodifiableListView<Receipt> get unmodifiableReceiptList => UnmodifiableListView(this._list);

  /// getter by index
  Receipt getReceiptByIndex(int index) => _list[index];

  /// get receipt on index name
  String getName(int index) => this._list[index].name;

  /*
  /// set turns on index
  void setTurns(int index, int t) => this._list[index].setTurns(t);
   */

  /// duration
  void addNewDuration(int index, MyDuration newDuration) {
    this._list[index].addNewDuration(newDuration);
    notifyListeners();
  }

  /// icon
  void setIconId(int index, int iconId) {
    this._list[index].iconId = iconId;
    notifyListeners();
  }

  /// steering value
  void setSteeringValue(int index, double s) => this._list[index].steeringSetting.value = s;

  /// steering main icon
  void setSteeringIcon(int receiptIndex, int level, int index) {
    switch (level) {
      case 0:
        this._list[receiptIndex].steeringSetting.firstStoveIconId = index;
        this._list[receiptIndex].steeringSetting.secondStoveIconId = -1;
        this._list[receiptIndex].steeringSetting.thirdStoveIconId = -1;
        break;
      case 1:
        this._list[receiptIndex].steeringSetting.secondStoveIconId = index;
        this._list[receiptIndex].steeringSetting.thirdStoveIconId = -1;
        break;
      case 2:
        this._list[receiptIndex].steeringSetting.thirdStoveIconId = index;
        break;
    }
    notifyListeners();
  }

  /// seconds
  void setSeconds(int index, int timerIndex, int s) {
    this._list[index].setSeconds(timerIndex, s);
    notifyListeners();
  }

  /// minutes
  void setMinutes(int index, int timerIndex, int s) {
    this._list[index].setMinutes(timerIndex, s);
    notifyListeners();
  }

  /// name
  void setName(int index, String name) {
    this._list[index].name = name;
    notifyListeners();
  }

  /// create new receipt and return its index
  int createReceipt() {
    Receipt newReceipt = ReceiptData.getDefaultReceipt();
    this._list.add(newReceipt);
    return this._list.indexOf(newReceipt);
  }

  /// toggle warmUpButton
  void toggleWarmUp(int index) {
    this._list[index].isWarmedUp = !this._list[index].isWarmedUp;
    notifyListeners();
  }

  /// toggle warmUpButton
  void setUnitId(int index, unitId) {
    this._list[index].steeringSetting.unitId = unitId;
    notifyListeners();
  }

  void initReceiptListFromJson(String json) {
    print('read json from device');
    initFromJson(jsonDecode(json));
    notifyListeners();
  }

  void deleteReceipt(int index) async {
    this._list.removeAt(index);
    await FileIO().writeString(jsonEncode(toJson()), FileIO().getReceiptsFile());
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {'receiptList': jsonEncode(this._list)};

  /// get count of all receipts
  int get receiptCount => _list.length;
}
