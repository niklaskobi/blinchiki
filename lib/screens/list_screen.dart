import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/default_steering_list.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/screens/stove_select_screen.dart';
import 'package:blinchiki_app/screens/timer_screen.dart';
import 'package:blinchiki_app/widgets/receipt_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blinchiki_app/data/constants.dart';

class ListScreen extends StatefulWidget {
  static const String id = 'list_screen';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    //TODO: if file doesn't exist create default initial list
    //TODO: test what happens if file doesn't exist / is corrupted
    /// Load receipts from phone's storage
    FileIO().readString(FileIO().getReceiptsFile()).then((String json) {
      Provider.of<ReceiptList>(context).initReceiptListFromJson(json);
    });

    /// Load default steering from phone's storage
    DefaultSteeringList().initDefaultSteering();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int newReceiptIndex = Provider.of<ReceiptList>(context).createReceipt();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TimerScreen(receiptIndex: newReceiptIndex, newReceipt: true)));
        },
        tooltip: 'Create new receipt',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10, right: 4, left: 4),
              color: kBackgroundWhite,
              child: ReceiptListWidget(),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: kReceiptCardBackground,
        shape: const CircularNotchedRectangle(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.tune),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StoveSelectScreen(activeIndex: 0)));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

/*

 */
