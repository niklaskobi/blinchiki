import 'package:flutter/widgets.dart';

class Unit {
  String label;
  int iconId;

  Unit({@required this.label, @required this.iconId});

  Unit copy() => Unit(label: this.label, iconId: this.iconId);

  Unit.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        iconId = json['iconId'];

  Map<String, dynamic> toJson() {
    print('SteeringSetting to json');
    return {
      'label': label,
      'iconId': iconId,
    };
  }
}
