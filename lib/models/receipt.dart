import 'dart:convert';

import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/steering_setting.dart';

class Receipt {
  String _name;
  List<MyDuration> _durations;
  int _iconId;
  int _stoveId;
  int _activeBurnerIndex;
  int _turns;
  SteeringSetting _steeringSetting;

  Receipt(
      {String name,
      List<MyDuration> durations,
      int iconId,
      int stoveId,
      int activeBurnerIndex,
      int turns,
      SteeringSetting steeringSetting}) {
    this._name = name;
    this._durations = durations;
    this._iconId = iconId;
    this._stoveId = stoveId;
    this._activeBurnerIndex = activeBurnerIndex;
    this._turns = turns;
    this._steeringSetting = steeringSetting;
  }

  /// getters and setters
  int getMinutes(int index) => this._durations[index].minutes;
  setMinutes(int index, int value) => this._durations[index].minutes = value;
  int getSeconds(int index) => this._durations[index].seconds;
  int getOverallSeconds(int index) => this._durations[index].getOverallSeconds();
  setSeconds(int index, int value) => this._durations[index].seconds = value;
  SteeringSetting get steeringSetting => this._steeringSetting;
  String get name => this._name;
  set name(String value) => this._name = value;
  int get iconId => this._iconId;
  int get turns => this._turns == null ? 0 : this._turns;
  setTurns(int t) => this._turns = t;

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
        _turns = json['turns'],
        _steeringSetting = SteeringSetting.fromJson(jsonDecode(json['steeringSetting']));

  /// serialization
  Map<String, dynamic> toJson() => {
        'name': _name,
        'durations': jsonEncode(_durations),
        'iconId': _iconId,
        'stoveId': _stoveId,
        'activeBurnerIndex': _activeBurnerIndex,
        'turns': _turns,
        'steeringSetting': jsonEncode(_steeringSetting)
      };

  /// copy constructor
  static Receipt copy(Receipt o) {
    return Receipt(
        name: o._name,
        durations: o._durations,
        iconId: o._iconId,
        stoveId: o._stoveId,
        activeBurnerIndex: o._activeBurnerIndex,
        turns: o._turns,
        steeringSetting: o._steeringSetting);
  }
}
