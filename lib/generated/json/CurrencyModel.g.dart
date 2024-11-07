import 'package:flutter_currency/generated/json/base/json_convert_content.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';

CurrencyModel $CurrencyModelFromJson(Map<String, dynamic> json) {
  final CurrencyModel currencyModel = CurrencyModel();
  final List<CurrencyModelData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CurrencyModelData>(e) as CurrencyModelData).toList();
  if (data != null) {
    currencyModel.data = data;
  }
  return currencyModel;
}

Map<String, dynamic> $CurrencyModelToJson(CurrencyModel entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension CurrencyModelExtension on CurrencyModel {
  CurrencyModel copyWith({
    List<CurrencyModelData>? data,
  }) {
    return CurrencyModel()
      ..data = data ?? this.data;
  }
}

CurrencyModelData $CurrencyModelDataFromJson(Map<String, dynamic> json) {
  final CurrencyModelData currencyModelData = CurrencyModelData();
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    currencyModelData.id = id;
  }
  final String? currency = jsonConvert.convert<String>(json['currency']);
  if (currency != null) {
    currencyModelData.currency = currency;
  }
  final String? currencyIcon = jsonConvert.convert<String>(json['currency_icon']);
  if (currencyIcon != null) {
    currencyModelData.currencyIcon = currencyIcon;
  }
  final double? twdPrice = jsonConvert.convert<double>(json['twd_price']);
  if (twdPrice != null) {
    currencyModelData.twdPrice = twdPrice;
  }
  final int? amountDecimal = jsonConvert.convert<int>(json['amount_decimal']);
  if (amountDecimal != null) {
    currencyModelData.amountDecimal = amountDecimal;
  }
  return currencyModelData;
}

Map<String, dynamic> $CurrencyModelDataToJson(CurrencyModelData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['currency'] = entity.currency;
  data['currency_icon'] = entity.currencyIcon;
  data['twd_price'] = entity.twdPrice;
  data['amount_decimal'] = entity.amountDecimal;
  return data;
}

extension CurrencyModelDataExtension on CurrencyModelData {
  CurrencyModelData copyWith({
    int? id,
    String? currency,
    String? currencyIcon,
    double? twdPrice,
    int? amountDecimal,
  }) {
    return CurrencyModelData()
      ..id = id ?? this.id
      ..currency = currency ?? this.currency
      ..currencyIcon = currencyIcon ?? this.currencyIcon
      ..twdPrice = twdPrice ?? this.twdPrice
      ..amountDecimal = amountDecimal ?? this.amountDecimal;
  }
}