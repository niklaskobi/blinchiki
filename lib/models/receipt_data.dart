import 'package:blinchiki_app/models/default_steering_list.dart';
import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:blinchiki_app/models/unit.dart';
import 'package:flutter/foundation.dart';

class ReceiptData extends ChangeNotifier {
  static int maxDurationAmount = 4;
  static SteeringSetting defaultSteering = SteeringSetting(
    min: 0,
    max: 3,
    step: 0.5,
    value: 0,
    unitId: 0,
    firstStoveIconId: 0,
    secondStoveIconId: -1,
    thirdStoveIconId: -1,
  );

  static MyDuration defaultDuration = MyDuration(minutes: 0, seconds: 0);
  static Receipt getDefaultReceipt() {
    DefaultSteeringList defaultSteeringList = DefaultSteeringList();
    return Receipt(
        name: '',
        durations: [defaultDuration.copy()],
        iconId: 1,
        stoveId: 1,
        activeBurnerIndex: 0,
        steeringSetting: defaultSteeringList.get()[0].setting.copy(),
        isWarmedUp: false);
  }

  /// default receipt list, used as initial list at the very 1 start of the app
  static List<Receipt> getDefaultReceiptList() {
    DefaultSteeringList defaultSteeringList = DefaultSteeringList();
    List<Receipt> ret = [
      Receipt(
          name: "Blini",
          durations: [defaultDuration.copy()],
          iconId: 1,
          stoveId: 1,
          activeBurnerIndex: 1,
          steeringSetting: defaultSteering.copy(),
          isWarmedUp: true),
      Receipt(
          name: "Chai",
          durations: [defaultDuration.copy()],
          iconId: 1,
          stoveId: 1,
          activeBurnerIndex: 1,
          steeringSetting: defaultSteering.copy(),
          isWarmedUp: false),
      Receipt(
          name: "Soup",
          durations: [defaultDuration.copy()],
          iconId: 1,
          stoveId: 1,
          activeBurnerIndex: 1,
          steeringSetting: defaultSteering.copy(),
          isWarmedUp: false),
      Receipt(
          name: "Makarohi",
          durations: [defaultDuration.copy()],
          iconId: 2,
          stoveId: 1,
          activeBurnerIndex: 1,
          steeringSetting: defaultSteering.copy(),
          isWarmedUp: true)
    ];
    return ret;
  }
}
