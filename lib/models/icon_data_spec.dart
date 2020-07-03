import 'package:blinchiki_app/models/icon_group.dart';
import 'package:flutter/material.dart';
import 'icon_spec.dart';
import 'icon_group.dart';

class IconDataSpec {
  static Map<int, IconGroup> _groupIdMap = {
    1: IconGroup(label: 'Fastfood', iconData: Icons.fastfood),
    2: IconGroup(label: 'Beverages', iconData: Icons.beach_access),
  };
  static Map<int, IconSpec> _iconsMap = {
    1: IconSpec(iconData: Icons.fastfood, groupId: 1),
    2: IconSpec(iconData: Icons.cake, groupId: 2),
  };

  static IconData getIconData(int iconId) {
    return _iconsMap[iconId].iconData;
  }
}
