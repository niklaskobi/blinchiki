import 'dart:convert';

import 'package:blinchiki_app/models/duration.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:flutter/foundation.dart';

class ReceiptData extends ChangeNotifier {
  static int maxDurationAmount = 4;
  static SteeringSetting defaultSteering = SteeringSetting(min: 0, max: 3, step: 0.5, value: 2, steeringId: 1);
  static MyDuration defaultDuration = MyDuration(minutes: 1, seconds: 20);
  //static MyDuration zeroDuration = MyDuration(minutes: 0, seconds: 0);
  static Receipt defaultReceipt = Receipt(
      name: '?',
      durations: [defaultDuration],
      iconId: 1,
      stoveId: 1,
      activeBurnerIndex: 0,
      steeringSetting: defaultSteering);

  /// default receipt list, used as initial list at the very 1 start of the app
  static List<Receipt> defaultReceiptList = [
    Receipt(
        name: "Blini",
        durations: [defaultDuration],
        iconId: 1,
        stoveId: 1,
        activeBurnerIndex: 1,
        steeringSetting: defaultSteering),
    Receipt(
        name: "Chai",
        durations: [defaultDuration],
        iconId: 1,
        stoveId: 1,
        activeBurnerIndex: 1,
        steeringSetting: defaultSteering),
    Receipt(
        name: "Soup",
        durations: [defaultDuration],
        iconId: 1,
        stoveId: 1,
        activeBurnerIndex: 1,
        steeringSetting: defaultSteering),
    Receipt(
        name: "Makarohi",
        durations: [defaultDuration],
        iconId: 2,
        stoveId: 1,
        activeBurnerIndex: 1,
        steeringSetting: defaultSteering)
  ];
}
