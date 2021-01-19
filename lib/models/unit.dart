import 'package:flutter/widgets.dart';

class Unit {
  String label;
  String path;
  int id;

  Unit({@required this.label, @required this.path, this.id});

  Unit copy() => Unit(label: this.label, path: this.path, id: this.id);

  Unit.fromJson(Map<String, dynamic> json)
      : label = json['label'],
        path = json['path'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'path': path,
      'id': id,
    };
  }
}
