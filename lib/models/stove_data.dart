import 'package:blinchiki_app/models/stove.dart';

class StoveData {
  //list of all possible stove instances
  static Map<int, Stove> stoveList = {
    1: Stove1.getStove(),
    2: Stove2Horizontal.getStove(),
    3: Stove2Vertical.getStove()
  };
}
