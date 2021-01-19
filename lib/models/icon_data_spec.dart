import 'package:blinchiki_app/models/icon_group.dart';
import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:blinchiki_app/models/unit.dart';
import 'package:flutter/material.dart';
import 'icon_spec.dart';
import 'icon_group.dart';
import 'package:blinchiki_app/data/constants.dart';

class IconPathWithId {
  String path;
  int id;

  IconPathWithId({@required this.path, @required this.id});
}

class IconDataSpec {
  /// making class a singleton
  static final IconDataSpec _instance = IconDataSpec._internal();
  IconDataSpec._internal();
  factory IconDataSpec() {
    return _instance;
  }

  //TODO: remove labels, they are not used anywhere
  List<Unit> _unitList = [
    Unit(label: '°C', path: 'assets/icons/units/regler.svg', id: 0),
    Unit(label: '°C', path: 'assets/icons/units/celsius.svg', id: 1),
    Unit(label: '°F', path: 'assets/icons/units/fahrenheit.svg', id: 2),
    Unit(label: '%', path: 'assets/icons/units/prozentsatz.svg', id: 3),
    Unit(label: '%', path: 'assets/icons/units/blitz.svg', id: 4),
    Unit(label: '', path: 'assets/icons/units/feuer_bw.svg', id: 5),
    Unit(label: '', path: 'assets/icons/units/strahlung_bw.svg', id: 6),
    Unit(label: '', path: 'assets/icons/units/inf.svg', id: 7),
    Unit(label: '', path: 'assets/icons/units/x-markierung.svg', id: 8),
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

  // TODO: link paths to the default settings
  List<IconPathWithId> _firstStoveIconsList = [
    IconPathWithId(path: 'assets/icons/general/stove.svg', id: 0),
    IconPathWithId(path: 'assets/icons/general/stove_1.svg', id: 1),
    IconPathWithId(path: 'assets/icons/general/microwave.svg', id: 2),
    IconPathWithId(path: 'assets/icons/general/grill.svg', id: 3),
    IconPathWithId(path: 'assets/icons/general/electric-grill.svg', id: 4),
    IconPathWithId(path: 'assets/icons/general/toaster_bread.svg', id: 5),
    IconPathWithId(path: 'assets/icons/general/gas.svg', id: 6),
    IconPathWithId(path: 'assets/icons/general/kitchen.svg', id: 7),
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
        return this._firstStoveIconsList.map((e) => e.path).toList();
        break;
      case 1:
        return this._secondStoveIconsList; // this is old, reimplement it if you want to use it
        break;
      case 2:
        return _getThirdLevelList(secondStoveId); // this is old, reimplement it if you want to use it
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
        return this._firstStoveIconsList[s.firstStoveIconId].path;
      case 2:
        return this._secondStoveIconsList[s.secondStoveIconId]; // this is old, reimplement it if you want to use it
      case 3:
        return _getThirdLevelList(
            s.secondStoveIconId)[s.thirdStoveIconId]; // this is old, reimplement it if you want to use it
      default:
        return UNDEF_STR;
    }
  }

  IconData getReceiptIconData(int iconId) => _receiptIconsList.firstWhere((i) => i.id == iconId).iconData;

  IconGroup getReceiptIconGroup(int id) => _receiptGroupIdList.firstWhere((i) => i.id == id);

  int getReceiptIconGroupCount() => _receiptGroupIdList.length;

  List<IconSpec> getReceiptIconsForGroup(int groupId) => _receiptIconsList.where((i) => i.groupId == groupId).toList();

  List<String> getUnitPathsList() => _unitList.map((i) => i.path).toList();
}
