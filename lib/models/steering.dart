abstract class Steering {
  String description;
  String iconPath;
  String unit;
}

/// Singleton class, describes a steering
class SteeringCelsius extends Steering {
  static SteeringCelsius _instance;

  /// Constructor
  SteeringCelsius._internal() {
    description = "Steering with Celsius Unit";
    iconPath = '';
    unit = 'C';
  }

  static SteeringCelsius getSteering() {
    if (_instance == null) {
      _instance = SteeringCelsius._internal();
    }
    return _instance;
  }
}

/// Singleton class, describes a steering
class SteeringFahrenheit extends Steering {
  static SteeringFahrenheit _instance;

  /// Constructor
  SteeringFahrenheit._internal() {
    description = "Steering with Fahrenheit Unit";
    iconPath = '';
    unit = 'F';
  }

  static SteeringFahrenheit getSteering() {
    if (_instance == null) {
      _instance = SteeringFahrenheit._internal();
    }
    return _instance;
  }
}
