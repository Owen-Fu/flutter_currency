class RegExpUtility {
  static final RegExp decimalInputFormatter = RegExp(r'^\d+\.?\d*$');
  static bool isValidDecimal(String input) => decimalInputFormatter.hasMatch(input);
}
