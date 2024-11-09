import 'package:flutter/services.dart';
import 'package:flutter_currency/Utility/RegExpUtility.dart';

class DecimalInputFormatter extends TextInputFormatter {
  // 正則表達式：僅允許數字和小數點
  final RegExp _regExp = RegExpUtility.decimalInputFormatter;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // 如果新輸入的內容符合正則表達式
    if (_regExp.hasMatch(newValue.text)) {
      // 檢查是否有連續兩個小數點
      if (!newValue.text.contains('..')) {
        return newValue;
      }
    }
    // 如果不符合規則，則保持舊的值
    return oldValue;
  }
}
