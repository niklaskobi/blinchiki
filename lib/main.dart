import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/list_screen.dart';
import 'screens/timer_screen.dart';

void main() => runApp(Blinchiki());

class Blinchiki extends StatelessWidget {
  static const String _title = 'Blinchiki';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => ReceiptList(),
      child: MaterialApp(
        theme: ThemeData(
          canvasColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          accentColor: Colors.pinkAccent,
          brightness: Brightness.dark,
          sliderTheme: SliderTheme.of(context).copyWith(
            inactiveTrackColor: Colors.black12,
            activeTrackColor: Colors.blue,
            thumbColor: Colors.blue,
            valueIndicatorColor: Colors.blue,
            //overlayColor: Color(0x29EB1555),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
          ),
        ),
        title: _title,
        initialRoute: ListScreen.id,
        routes: {
          ListScreen.id: (context) => ListScreen(),
          TimerScreen.id: (context) => TimerScreen(receiptIndex: -1, newReceipt: true),
        },
      ),
    );
  }
}
