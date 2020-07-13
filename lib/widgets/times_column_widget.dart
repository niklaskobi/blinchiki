import 'package:flutter/material.dart';
import 'package:blinchiki_app/models/duration.dart';

class TimesColumnWidget extends StatelessWidget {
  final List<MyDuration> durations;
  int activeIndex;

  TimesColumnWidget({this.durations, this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(this.durations[0].toString()),
      ],
    );
  }
}
