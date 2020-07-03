import 'package:blinchiki_app/widgets/timer_painter.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  AnimationController controller;

  TimerWidget({this.controller});

  String getTimerString() {
    Duration duration =
        controller.status == AnimationStatus.dismissed ? controller.duration : controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.08),
      child: Align(
        alignment: FractionalOffset.center,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return new CustomPaint(
                    painter: TimerPainter(
                      animation: controller,
                      backgroundColor: Colors.grey,
                      color: themeData.indicatorColor,
                    ),
                  );
                },
              )),
              Align(
                alignment: FractionalOffset.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Text("Count Down", style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05)),
                    AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return new Text(getTimerString(),
                              //style: themeData.textTheme.display4,
                              style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.25));
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
