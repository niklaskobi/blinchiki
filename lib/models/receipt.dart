import 'dart:convert';

import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
import 'package:blinchiki_app/models/steering_setting.dart';

class Receipt {
  String _name;
  List<MyDuration> _durations;
  int _iconId;
  int _stoveId;
  int _activeBurnerIndex;
  //int _turns;
  SteeringSetting _steeringSetting;

  /// constructor
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
    //this._turns = turns;
    this._steeringSetting = steeringSetting;
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

  /*
  /// turns
  int get turns => this._turns == null ? 0 : this._turns;
  setTurns(int t) => this._turns = t;
   */

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
        //_turns = json['turns'],
        _steeringSetting = SteeringSetting.fromJson(jsonDecode(json['steeringSetting']));

  /// serialization
  Map<String, dynamic> toJson() => {
        'name': _name,
        'durations': jsonEncode(_durations),
        'iconId': _iconId,
        'stoveId': _stoveId,
        'activeBurnerIndex': _activeBurnerIndex,
        //'turns': _turns,
        'steeringSetting': jsonEncode(_steeringSetting)
      };

  /// copy constructor
  Receipt copy() {
    return Receipt(
        name: this._name,
        durations: this._durations,
        iconId: this._iconId,
        stoveId: this._stoveId,
        activeBurnerIndex: this._activeBurnerIndex,
        //turns: this._turns,
        steeringSetting: this._steeringSetting);
  }
}
