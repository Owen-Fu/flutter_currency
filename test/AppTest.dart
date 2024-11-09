import 'package:flutter_currency/Utility/Net/requester.dart';
import 'package:flutter_currency/generated/json/base/json_convert_content.dart';
import 'package:flutter_test/flutter_test.dart';

class AppTest {
  static void testSetUpAll() {
    setUpAll(_setupAll);
  }

  static void _setupAll() async {
    Requester();
    Requester.ins.respParser = (type, response) {
      return (jsonConvert.convertFuncMap[type.toString()])?.call((response.data ?? {}));
    };
  }
}