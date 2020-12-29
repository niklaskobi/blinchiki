import 'package:flutter/widgets.dart';

class Unit {
  String label;
  String path;

  Unit({@required this.label, @required this.path});

  Unit copy() => Unit(label: this.label, path: this.path);

  Unit.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        path = json['path'];

  Map<String, dynamic> toJson() {
    print('SteeringSetting to json');
    return {
      'label': label,
      'path': path,
    };
  }
}
