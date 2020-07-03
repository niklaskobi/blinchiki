import 'package:blinchiki_app/data/fileIO.dart';
import 'package:blinchiki_app/models/receipt_data.dart';
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
    FileIO().readString().then((String json) {
      Provider.of<ReceiptData>(context).updateReceiptList(json);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            //Navigator.pushNamed(context, TimerScreen.id),
            Navigator.push(context, MaterialPageRoute(builder: (context) => TimerScreen(receipt: null))),
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: new Row(
          //mainAxisSize: MainAxisSize.max,
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
    );
  }
}

/*

 */
