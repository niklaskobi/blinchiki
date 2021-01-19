import 'dart:convert';
import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:flutter/cupertino.dart';

class DefaultSteering {
  SteeringSetting _setting;
  int _iconId;

  /// constructor
  DefaultSteering({@required SteeringSetting steeringSetting, @required int iconId}) {
    this._setting = steeringSetting;
    this._iconId = iconId;
  }

  int get iconId => this._iconId;

  SteeringSetting get setting => this._setting;

  /// parse Duration list
  static List<MyDuration> durationsFromJson(String json) =>
      (jsonDecode(json) as List).map((i) => MyDuration.fromJson(i)).toList();

  /// deserialization
  DefaultSteering.fromJson(Map<String, dynamic> json)
      : _setting = SteeringSetting.fromJson(jsonDecode(json['steeringSetting'])),
        _iconId = json['iconId'];

  /// serialization
  Map<String, dynamic> toJson() => {
        'steeringSetting': jsonEncode(_setting),
        'iconId': _iconId,
      };
}
