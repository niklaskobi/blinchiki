import 'package:blinchiki_app/models/steering.dart';

class SteeringData {
  //list of all possible stove instances
  static final Map<int, Steering> _steeringMap = {
    1: SteeringCelsius.getSteering(),
    2: SteeringFahrenheit.getSteering(),
  };

  static Steering getSteering(int steeringId) {
    return _steeringMap[steeringId];
  }
}
