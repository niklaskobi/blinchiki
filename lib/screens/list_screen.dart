import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/screens/timer_screen.dart';
import 'package:blinchiki_app/widgets/receipt_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    FileIO().readString().then((String json) {
      Provider.of<ReceiptList>(context).initReceiptListFromJson(json);
    });
    //print("receiptList was initiated: ${Provider.of<ReceiptList>(context).get()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int newReceiptIndex = Provider.of<ReceiptList>(context).createReceipt();
          Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen(index: newReceiptIndex)));
        },
        tooltip: 'Create new receipt',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ReceiptListWidget(),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /*
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
       */
    );
  }
}

/*

 */
