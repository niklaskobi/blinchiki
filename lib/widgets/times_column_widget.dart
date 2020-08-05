import 'package:flutter/material.dart';
import 'package:blinchiki_app/models/duration.dart';

class TimesColumnWidget extends StatefulWidget {
  final List<MyDuration> durations;
  final activeIndex;

  TimesColumnWidget({this.durations, this.activeIndex});

  @override
  _TimesColumnWidgetState createState() => _TimesColumnWidgetState();
}

class _TimesColumnWidgetState extends State<TimesColumnWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          //height: 30,
          width: 50,
          child: ListView.builder(
              //padding: const EdgeInsets.all(8),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.durations.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  //height: 50,
                  child: Center(
                    child: Text(
                      this.widget.durations[index].toString(),
                      style: TextStyle(fontWeight: index == widget.activeIndex ? FontWeight.w600 : FontWeight.w100),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
