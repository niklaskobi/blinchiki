import 'dart:convert';

import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/unit.dart';
import 'package:flutter/cupertino.dart';

class SteeringSetting {
  double min;
  double max;
  double step;
  double value;
  int unitId;
  int mainStoveIconId; //TODO: delete this
  int firstStoveIconId;
  int secondStoveIconId;
  int thirdStoveIconId;

  IconDataSpec iconDataSpec = IconDataSpec();

  bool isIndexActive(int level, int index) {
    switch (level) {
      case 0:
        return firstStoveIconId == index;
        break;
      case 1:
        return secondStoveIconId == index;
        break;
      case 2:
        return thirdStoveIconId == index;
        break;
    }
    return false;
  }

  SteeringSetting({
    @required this.min,
    @required this.max,
    @required this.step,
    @required this.value,
    @required this.unitId,
    @required this.mainStoveIconId,
    @required this.firstStoveIconId,
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
      firstStoveIconId: this.firstStoveIconId,
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
        firstStoveIconId = json['firstStoveIconId'],
        secondStoveIconId = json['secondStoveIconId'],
        thirdStoveIconId = json['thirdStoveIconId'];

  Map<String, dynamic> toJson() => {
        'min': min,
        'max': max,
        'step': step,
        'value': value,
        'unitId': unitId,
        'mainStoveIconId': mainStoveIconId,
        'firstStoveIconId': firstStoveIconId,
        'secondStoveIconId': secondStoveIconId,
        'thirdStoveIconId': thirdStoveIconId,
      };
}
