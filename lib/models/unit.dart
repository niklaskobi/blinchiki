import 'package:flutter/widgets.dart';

enum UnitIconId {
  celsius,
  fahrenheit,
}

class Unit {
  UnitIconId id;
  IconData icon;

  Unit({@required this.id, @required this.icon});
}
