int rotatingIncrement(int curValue, int minValue, int maxValue) {
  return curValue + 1 <= maxValue ? curValue + 1 : minValue;
}

int increaseWithBoundary(int curValue, int maxValue) {
  return curValue + 1 <= maxValue ? curValue + 1 : curValue;
}

int decreaseWithBoundary(int curValue, int minValue) {
  return curValue - 1 >= minValue ? curValue - 1 : curValue;
}
