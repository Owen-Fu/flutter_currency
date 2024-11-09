class RegExpUtility {
  static final RegExp dotsZeros = RegExp(r'\.0+$');
  static final RegExp decimalInputFormatter = RegExp(r'^\d*\.?\d*$');
  static bool isValidDecimal(String input) => decimalInputFormatter.hasMatch(input);
  static String removeTrailingDotsZeros(String input) => input.replaceFirst(dotsZeros, '');
}
