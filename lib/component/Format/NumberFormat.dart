String cleanDouble(double number) {
  String numberStr = number.toString();
  if (numberStr.endsWith('.0')) {
    numberStr = numberStr.substring(0, numberStr.length - 2);
  }
  return numberStr;
}