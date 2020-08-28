import 'package:blinchiki_app/models/icon_group.dart';
import 'package:blinchiki_app/models/unit.dart';
import 'package:flutter/material.dart';
import 'icon_spec.dart';
import 'icon_group.dart';

class IconDataSpec {
  /// making class a singleton
  static final IconDataSpec _instance = IconDataSpec._internal();
  IconDataSpec._internal();
  factory IconDataSpec() {
    return _instance;
  }

  List<Unit> _unitList = [
    Unit(id: UnitIconId.celsius, icon: Icons.translate),
    Unit(id: UnitIconId.fahrenheit, icon: Icons.translate),
  ];

  List<IconGroup> _groupIdList = [
    IconGroup(label: 'Fastfood', iconData: Icons.fastfood, id: 0),
    IconGroup(label: 'Beverages', iconData: Icons.beach_access, id: 1),
    IconGroup(label: 'Brakfast', iconData: Icons.style, id: 2),
  ];

  List<IconSpec> _iconsList = [
    IconSpec(iconData: Icons.fastfood, groupId: 0, id: 0),
    IconSpec(iconData: Icons.email, groupId: 0, id: 1),
    IconSpec(iconData: Icons.save, groupId: 0, id: 2),
    IconSpec(iconData: Icons.accessibility, groupId: 0, id: 3),
    IconSpec(iconData: Icons.account_balance, groupId: 0, id: 4),
    IconSpec(iconData: Icons.https, groupId: 0, id: 5),
    IconSpec(iconData: Icons.adb, groupId: 0, id: 6),
    IconSpec(iconData: Icons.cake, groupId: 1, id: 100),
    IconSpec(iconData: Icons.ac_unit, groupId: 2, id: 200),
  ];

  IconData getIconData(int iconId) => _iconsList.firstWhere((i) => i.id == iconId).iconData;

  IconGroup getIconGroup(int id) => _groupIdList.firstWhere((i) => i.id == id);

  int getIconGroupCount() => _groupIdList.length;

  List<IconSpec> getIconsForGroup(int groupId) => _iconsList.where((i) => i.groupId == groupId).toList();
}
