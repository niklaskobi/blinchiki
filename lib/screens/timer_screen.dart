import 'package:blinchiki_app/models/icon_data_spec.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/screens/receipt_settings_screen.dart';
import 'package:blinchiki_app/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatefulWidget {
  static const String id = 'timer_screen';

  final int receiptIndex;
  final bool newReceipt;

  TimerScreen({this.receiptIndex, this.newReceipt});

  @override
  _TimerScreenState createState() {
    return _TimerScreenState();
  }
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin {
  String receiptTitle = '';
  AnimationController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int duration =
        Provider.of<ReceiptList>(context, listen: true).getReceiptByIndex(widget.receiptIndex).getOverallSeconds(0);
    controller = AnimationController(
      vsync: this,
      //duration: Duration(seconds: this._receipt.getOverallSeconds(0)),
      duration: Duration(seconds: duration),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: screenHeight * 0.03, width: screenWidth),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Consumer<ReceiptList>(builder: (context, receiptList, child) {
                        return Icon(IconDataSpec.getIconData(receiptList.getReceiptByIndex(widget.receiptIndex).iconId),
                            size: screenWidth * 0.08);
                      }), //TODO: refactor get icon data, move it to receipt
                      SizedBox(width: screenWidth * 0.05),
                      Consumer<ReceiptList>(
                        builder: (context, receiptList, child) {
                          return Text(
                            receiptList.getReceiptByIndex(widget.receiptIndex).name,
                            style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black54),
                          );
                        },
                      ),
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
            ),
            ReceiptSettingsScreen(receiptIndex: widget.receiptIndex, newReceipt: widget.newReceipt),
          ],
        ),
      ),
    );
  }
}

/*


 */
