import 'dart:convert';
import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/default_steering.dart';
import 'package:blinchiki_app/models/steering_setting.dart';

class DefaultSteeringList {
  /// making class a singleton
  static final DefaultSteeringList _instance = DefaultSteeringList._internal();
  DefaultSteeringList._internal();
  factory DefaultSteeringList() {
    return _instance;
  }

  List<DefaultSteering> _list;

  /// LAST STOP: finished, next : save default steerings, complete list.

  ///TODO: complete the default list
  void loadHardCodedSteering() {
    this._list = [
      DefaultSteering(
          steeringSetting: SteeringSetting(
              min: 1,
              max: 10,
              step: 1,
              value: 4,
              unitId: 0,
              firstStoveIconId: 0,
              secondStoveIconId: -1,
              thirdStoveIconId: -1),
          iconId: 0),
      DefaultSteering(
          steeringSetting: SteeringSetting(
              min: 0,
              max: 260,
              step: 10,
              value: 180,
              unitId: 1,
              firstStoveIconId: 0,
              secondStoveIconId: -1,
              thirdStoveIconId: -1),
          iconId: 1),
      DefaultSteering(
          steeringSetting: SteeringSetting(
              min: 1,
              max: 100,
              step: 10,
              value: 20,
              unitId: 4,
              firstStoveIconId: -1,
              secondStoveIconId: -1,
              thirdStoveIconId: -1),
          iconId: 2),
    ];
  }

  SteeringSetting getSetting(int iconId) {
    return this._list.firstWhere((e) => e.iconId == iconId).setting;
  }

  List<DefaultSteering> get() => this._list;

  /// parse steering list
  static List<DefaultSteering> defaultSteeringsFromJson(String json) =>
      (jsonDecode(json) as List).map((i) => DefaultSteering.fromJson(i)).toList();

  /// deserialization
  void initFromJson(Map<String, dynamic> json) => this._list = defaultSteeringsFromJson(json['defaultSteeringList']);

  /// change steering
  void changeDefaultSteering(int iconId, SteeringSetting setting) async {
    int index = -1;
    for (int i = 0; i < _list.length; i++) {
      if (_list[i].iconId == iconId) index = i;
    }
    _list[index] = DefaultSteering(steeringSetting: setting.copy(), iconId: iconId);
    await FileIO().writeString(jsonEncode(toJson()), FileIO().getReceiptsFile());
  }

  Map<String, dynamic> toJson() => {'defaultSteeringList': jsonEncode(this._list)};

  void initDefaultSteeringsFromJson(String json) {
    print('Loaded default settings json from device: "$json"');
    if (json == null || json.isEmpty) {
      print("Couldn't read default steering. Use hard coded default steering");
      loadHardCodedSteering();
    } else {
      initFromJson(jsonDecode(json));
    }
  }

  void initDefaultSteering() {
    print("Initialization of default steering list..");
    FileIO().readString(FileIO().getSteeringFile()).then((String json) {
      initDefaultSteeringsFromJson(json);
    });
  }
}
