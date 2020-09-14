import 'dart:convert';
import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:flutter/cupertino.dart';

class Receipt {
  String _name;
  List<MyDuration> _durations;
  int _iconId;
  int _stoveId;
  int _activeBurnerIndex;
  SteeringSetting _steeringSetting;
  bool _isWarmedUp;

  /// constructor
  Receipt(
      {@required String name,
      @required List<MyDuration> durations,
      @required int iconId,
      @required int stoveId,
      @required int activeBurnerIndex,
      @required SteeringSetting steeringSetting,
      @required bool isWarmedUp}) {
    this._name = name;
    this._durations = durations;
    this._iconId = iconId;
    this._stoveId = stoveId;
    this._activeBurnerIndex = activeBurnerIndex;
    this._steeringSetting = steeringSetting;
    this._isWarmedUp = isWarmedUp;
  }

  /// duration
  getDurationStr(int index) => this._durations[index].toString();
  getDurationAmount() => this._durations.length;
  addNewDuration(MyDuration newDuration) => this._durations.add(newDuration);
  removeDuration() => this._durations.removeLast();
  getDuration(int index) => this._durations[index];
  List<MyDuration> get durations => this._durations;

  /// minutes
  int getMinutes(int index) => this._durations[index].minutes;
  setMinutes(int index, int value) => this._durations[index].minutes = value;

  /// seconds
  int getSeconds(int index) => this._durations[index].seconds;
  setSeconds(int index, int value) => this._durations[index].seconds = value;
  int getOverallSeconds(int index) => this._durations[index].getOverallSeconds(); //TODO: sum up all durations

  /// steering
  SteeringSetting get steeringSetting => this._steeringSetting;

  /// name
  String get name => this._name;
  set name(String value) => this._name = value;

  /// icon
  int get iconId => this._iconId;
  set iconId(int id) => this._iconId = id;

  /// isWarmedUp
  bool get isWarmedUp => this._isWarmedUp;
  set isWarmedUp(bool w) => this._isWarmedUp = w;

  /// parse Duration list
  static List<MyDuration> durationsFromJson(String json) =>
      (jsonDecode(json) as List).map((i) => MyDuration.fromJson(i)).toList();

  /// deserialization
  Receipt.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _durations = durationsFromJson(json['durations']),
        _iconId = json['iconId'],
        _stoveId = json['stoveId'],
        _activeBurnerIndex = json['activeBurnerIndex'],
        _steeringSetting = SteeringSetting.fromJson(jsonDecode(json['steeringSetting'])),
        _isWarmedUp = json['isWarmedUp'];

  /// serialization
  Map<String, dynamic> toJson() {
    print('receit to json');
    String test2 = jsonEncode(_steeringSetting);
    print('steeringJson = $test2');
    Map<String, dynamic> test = {
      'name': _name,
      'durations': jsonEncode(_durations),
      'iconId': _iconId,
      'stoveId': _stoveId,
      'activeBurnerIndex': _activeBurnerIndex,
      'steeringSetting': jsonEncode(_steeringSetting),
      'isWarmedUp': _isWarmedUp,
    };
    print('test = $test');
    return test;
  }

  /// copy constructor
  Receipt copy() {
    return Receipt(
      name: this._name,
      durations: List<MyDuration>.from(this._durations),
      iconId: this._iconId,
      stoveId: this._stoveId,
      activeBurnerIndex: this._activeBurnerIndex,
      steeringSetting: this._steeringSetting.copy(),
      isWarmedUp: this._isWarmedUp,
    );
  }
}
