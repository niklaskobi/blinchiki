int rotatingIncrement(int curValue, int minValue, int maxValue) {
  return curValue + 1 <= maxValue ? curValue + 1 : minValue;
}
