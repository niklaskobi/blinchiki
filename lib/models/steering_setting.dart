import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:blinchiki_app/models/unit.dart';

class SteeringSetting {
  double min;
  double max;
  double step;
  double value;
  int unitId;
  int mainStoveIconId;
  int secondStoveIconId;
  int thirdStoveIconId;

  SteeringSetting({
    @required this.min,
    @required this.max,
    @required this.step,
    @required this.value,
    @required this.unitId,
    @required this.mainStoveIconId,
    @required this.secondStoveIconId,
    @required this.thirdStoveIconId,
  });

  SteeringSetting copy() {
    return SteeringSetting(
      min: this.min,
      max: this.max,
      step: this.step,
      value: this.value,
      unitId: this.unitId,
      mainStoveIconId: this.mainStoveIconId,
      secondStoveIconId: this.secondStoveIconId,
      thirdStoveIconId: this.thirdStoveIconId,
    );
  }

  SteeringSetting.fromJson(Map<String, dynamic> json)
      : min = json['min'],
        max = json['max'],
        step = json['step'],
        value = json['value'],
        unitId = json['unitId'],
        mainStoveIconId = json['mainStoveIconId'],
        secondStoveIconId = json['secondStoveIconId'],
        thirdStoveIconId = json['thirdStoveIconId'];

  Map<String, dynamic> toJson() {
    print('SteeringSetting to json');
    return {
      'min': min,
      'max': max,
      'step': step,
      'value': value,
      'unitId': unitId,
      'mainStoveIconId': mainStoveIconId,
      'secondStoveIconId': secondStoveIconId,
      'thirdStoveIconId': thirdStoveIconId,
    };
  }
}
