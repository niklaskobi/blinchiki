import 'package:blinchiki_app/models/steering_setting.dart';
import 'package:blinchiki_app/widgets/svg_icons_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blinchiki_app/models/receipt.dart';
import 'package:blinchiki_app/models/receipt_list.dart';
import 'package:blinchiki_app/data/fileIO.dart';
import 'dart:convert';

class SteeringScrollableBlockWidget extends StatefulWidget {
  final int receiptIndex;

  SteeringScrollableBlockWidget({@required this.receiptIndex});

  @override
  _SteeringScrollableBlockWidgetState createState() => _SteeringScrollableBlockWidgetState();
}

class _SteeringScrollableBlockWidgetState extends State<SteeringScrollableBlockWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem; // The next item inserted when the user presses the '+' button.

  @override
  void initState() {
    super.initState();
    _nextItem = 0;
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
      receiptIndex: widget.receiptIndex,
      iconSelectionFunction: iconSelection,
    );
  }

  void updateIconList(int level) {
    SteeringSetting steering =
        Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(widget.receiptIndex).steeringSetting;
    // level 1 and stove selected -> open next level
    if (steering.getHighestStoveLevel() == 1 && steering.firstStoveIconId == 0) {
      _insert();
    }
    // level 2 and something selected -> open third level
    else if (steering.getHighestStoveLevel() == 2 && steering.secondStoveIconId != -1) {
      _insert();
    }
  }

  void iconSelection(int level, int newIconId) {
    // set icon in receipt
    Provider.of<ReceiptList>(context, listen: false).setSteeringIcon(widget.receiptIndex, level, newIconId);
    // write to device's memory
    writeReceiptsToDevice();
  }

  /// write receipt list to the device's storage
  void writeReceiptsToDevice() async {
    await FileIO().writeString(jsonEncode(Provider.of<ReceiptList>(context).toJson()));
  }

  // Used to build an item after it has been removed from the list. This
  // method is needed because a removed item remains visible until its
  // animation has completed (even though it's gone as far this ListModel is
  // concerned). The widget will be used by the
  // [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
      receiptIndex: widget.receiptIndex,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }

  /*
  @override
  Widget build(BuildContext context) {
    Iterable<int> initItems = getInitList(context);
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: initItems,
      removedItemBuilder: _buildRemovedItem,
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedList'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body: AnimatedList(
          key: _listKey,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),
      ),
    );
  }
   */

  @override
  Widget build(BuildContext context) {
    Iterable<int> initItems = getInitList(context);
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: initItems,
      removedItemBuilder: _buildRemovedItem,
    );
    return MaterialApp(
      home: AnimatedList(
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Iterable<int> getInitList(BuildContext context) {
    Receipt receipt = Provider.of<ReceiptList>(context, listen: false).getReceiptByIndex(widget.receiptIndex);
    Iterable<int> initItems;
    if (receipt.steeringSetting.getHighestStoveLevel() == 3)
      initItems = <int>[0, 1, 2];
    else if (receipt.steeringSetting.getHighestStoveLevel() == 2)
      initItems = <int>[0, 1];
    else
      initItems = <int>[0];
    return initItems;
  }
}

/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    print("insert into $_items, index; $index, item: $item");
    _items.insert(index, item);
    print("inserted: $_items");
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) => removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value.
///
/// The text is displayed in bright green if [selected] is
/// true. This widget's height is based on the [animation] parameter, it
/// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.animation,
    this.onTap,
    @required this.item,
    this.selected = false,
    @required this.receiptIndex,
    this.isActiveFunction,
    this.list,
    this.iconSelectionFunction,
    this.svgSizeFactor = 0.6,
  })  : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;
  final int receiptIndex;
  final Function iconSelectionFunction;
  final Function isActiveFunction;
  final List<String> list;
  final double svgSizeFactor;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline4;

    if (selected) textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: Center(
            child: SvgIconsListWidget(
          receiptIndex: receiptIndex,
          iconPathList: list,
          isActive: isActiveFunction,
          onTap: iconSelectionFunction,
          svgSizeFactor: svgSizeFactor,
        )),
      ),
    );
  }
}

/*
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    IconDataSpec iconDataSpec = IconDataSpec();

    Container separator() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        height: screenHeight * 0.002,
        width: screenWidth * 0.4,
        decoration:
            BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10.0)), //TODO: take background color
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final iconGroup = iconDataSpec.getReceiptIconGroup(index);
        final iconList = iconDataSpec.getReceiptIconsForGroup(index);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                separator(),
                Icon(iconGroup.iconData),
                separator(),
              ],
            ),
            IconsListWidget(list: iconList, activeIndex: widget.activeIndex),
          ],
        );
      },
      itemCount: iconDataSpec.getReceiptIconGroupCount(),
    );
  }
}
 */
