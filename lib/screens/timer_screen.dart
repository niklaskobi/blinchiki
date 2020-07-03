import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
import 'package:blinchiki_app/screens/receipt_settings_screen.dart';
import 'package:blinchiki_app/widgets/timer_painter.dart';
import 'package:blinchiki_app/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  static const String id = 'timer_screen';

  Receipt receipt;
  bool newReceipt;

  TimerScreen({Receipt receipt}) {
    if (receipt != null) {
      this.receipt = receipt;
      this.newReceipt = false;
    } else {
      this.receipt = ReceiptData.defaultReceipt;
      this.newReceipt = true;
    }
  }

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin {
  String receiptTitle = '';

  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.receipt.getOverallSeconds(0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.03, width: screenWidth),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(IconDataSpec.getIconData(widget.receipt.iconId), size: screenWidth * 0.08),
                    SizedBox(width: screenWidth * 0.05),
                    Text(widget.receipt.name, style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black54)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03, width: screenWidth),
                TimerWidget(controller: controller),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return new Icon(controller.isAnimating ? Icons.pause : Icons.play_arrow);
                          },
                        ),
                        onPressed: () {
                          setState(() {
                            if (controller.isAnimating) {
                              controller.stop(canceled: true);
                              print(controller.isAnimating);
                            } else
                              controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            ReceiptSettingsScreen(
              receipt: widget.receipt,
              newReceipt: widget.newReceipt,
            ),
          ],
        ),
      ),
    );
  }
}

/*


 */
