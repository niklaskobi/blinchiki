import 'dart:math';

int rotatingIncrement(int curValue, int minValue, int maxValue) {
  return curValue + 1 <= maxValue ? curValue + 1 : minValue;
}

int increaseWithBoundary(int curValue, int maxValue) {
  return curValue + 1 <= maxValue ? curValue + 1 : curValue;
}

int decreaseWithBoundary(int curValue, int minValue) {
  return curValue - 1 >= minValue ? curValue - 1 : curValue;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}
