import 'package:blinchiki_app/models/icon_group.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:blinchiki_app/models/unit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'icon_spec.dart';
import 'icon_group.dart';
import 'package:blinchiki_app/data/constants.dart';

class IconDataSpec {
  /// making class a singleton
  static final IconDataSpec _instance = IconDataSpec._internal();
  IconDataSpec._internal();
  factory IconDataSpec() {
    return _instance;
  }

  List<Unit> _unitList = [
    Unit(label: '°C', iconId: 0),
    Unit(label: '°F', iconId: 1),
  ];

  List<IconGroup> _receiptGroupIdList = [
    IconGroup(label: 'Fastfood', iconData: Icons.fastfood, id: 0),
    IconGroup(label: 'Beverages', iconData: Icons.beach_access, id: 1),
    IconGroup(label: 'Brakfast', iconData: Icons.style, id: 2),
  ];

  List<IconSpec> _receiptIconsList = [
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

  List<String> _firstStoveIconsList = [
    'assets/icons/general/stove.svg',
    'assets/icons/general/grill.svg',
    'assets/icons/general/microwave.svg',
    'assets/icons/general/bbq.svg',
    'assets/icons/general/electric-grill.svg',
    'assets/icons/general/blender.svg',
    'assets/icons/general/toaster_bread.svg',
    'assets/icons/general/gas.svg',
    'assets/icons/general/kitchen.svg',
    'assets/icons/general/stove_1.svg',
  ];

  List<String> _secondStoveIconsList = [
    'assets/icons/stoves/stove_1_0.svg',
    'assets/icons/stoves/stove_2h_0.svg',
    'assets/icons/stoves/stove_2v_0.svg',
    'assets/icons/stoves/stove_4_0.svg',
    'assets/icons/stoves/stove_5_0.svg',
    'assets/icons/stoves/stove_6_0.svg',
  ];

  //TODO create all thirdLevel lists
  List<String> thirdStoveIconsList1 = ['assets/icons/stoves/stove_1_1.svg'];

  List<String> getStoveIconsList(int level, {int secondStoveId: -1}) {
    switch (level) {
      case 0:
        return this._firstStoveIconsList;
        break;
      case 1:
        return this._secondStoveIconsList;
        break;
      case 2:
        return _getThirdLevelList(secondStoveId);
        break;
    }
    return null;
  }

  // TODO: complete this
  List<String> _getThirdLevelList(int secondLevelIndex) {
    switch (secondLevelIndex) {
      case 0:
        return thirdStoveIconsList1;
        break;
    }
    return null;
  }

  /// returns main stove icon. If it is a steering with multiple levels (such as stove)
  /// returns the most deep selected icon (i.e a stove with only bottom right red circle)
  String getMainStoveIcon(SteeringSetting s) {
    switch (s.getHighestStoveLevel()) {
      case 1:
        return this._firstStoveIconsList[s.firstStoveIconId];
      case 2:
        return this._secondStoveIconsList[s.secondStoveIconId];
      case 3:
        return _getThirdLevelList(s.secondStoveIconId)[s.thirdStoveIconId];
      default:
        return UNDEF_STR;
    }
  }

  IconData getReceiptIconData(int iconId) => _receiptIconsList.firstWhere((i) => i.id == iconId).iconData;

  IconGroup getReceiptIconGroup(int id) => _receiptGroupIdList.firstWhere((i) => i.id == id);

  int getReceiptIconGroupCount() => _receiptGroupIdList.length;

  List<IconSpec> getReceiptIconsForGroup(int groupId) => _receiptIconsList.where((i) => i.groupId == groupId).toList();
}
