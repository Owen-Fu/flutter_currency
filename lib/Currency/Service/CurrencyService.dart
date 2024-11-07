import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Utility/Api.dart';
import 'package:flutter_currency/Utility/Net/requester.dart';

class CurrencyService {
  Future<CurrencyModel?> getCurrencyPairs() => Requester.ins.get(Api.getCurrencyPairs);
}
