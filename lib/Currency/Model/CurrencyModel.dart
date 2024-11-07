import 'package:flutter_currency/Utility/Net/base_server_resp.dart';
import 'package:flutter_currency/generated/json/CurrencyModel.g.dart';
import 'package:flutter_currency/generated/json/base/json_field.dart';
import 'dart:convert';

@JsonSerializable()
class CurrencyModel implements BaseServerResp {
  List<CurrencyModelData>? data;

  CurrencyModel();

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => $CurrencyModelFromJson(json);

  Map<String, dynamic> toJson() => $CurrencyModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }

  @override
  int? httpStatus;

  String getMockData() {
    return '''
[
    {
        "currency": "OMR",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 51387.29,
        "amount_decimal": "4",
        "id": "1"
    },
    {
        "currency": "NZD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 29856.83,
        "amount_decimal": "6",
        "id": "2"
    },
    {
        "currency": "LTL",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 17975.59,
        "amount_decimal": "9",
        "id": "3"
    },
    {
        "currency": "TND",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 90481.5,
        "amount_decimal": "3",
        "id": "4"
    },
    {
        "currency": "XPD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 5546.95,
        "amount_decimal": "8",
        "id": "5"
    },
    {
        "currency": "KMF",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 13686.11,
        "amount_decimal": "9",
        "id": "6"
    },
    {
        "currency": "CUC",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 99702.09,
        "amount_decimal": "7",
        "id": "7"
    },
    {
        "currency": "MDL",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 56017.28,
        "amount_decimal": "7",
        "id": "8"
    },
    {
        "currency": "VUV",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 96852.81,
        "amount_decimal": "1",
        "id": "9"
    },
    {
        "currency": "CUP",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 57355.5,
        "amount_decimal": "3",
        "id": "10"
    },
    {
        "currency": "BSD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 32092.87,
        "amount_decimal": "9",
        "id": "11"
    },
    {
        "currency": "BTN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 58602.09,
        "amount_decimal": "3",
        "id": "12"
    },
    {
        "currency": "AZN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 39522.99,
        "amount_decimal": "1",
        "id": "13"
    },
    {
        "currency": "TOP",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 601.29,
        "amount_decimal": "4",
        "id": "14"
    },
    {
        "currency": "XPD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 71747.91,
        "amount_decimal": "1",
        "id": "15"
    },
    {
        "currency": "SLL",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 40242.66,
        "amount_decimal": "8",
        "id": "16"
    },
    {
        "currency": "QAR",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 76636.44,
        "amount_decimal": "2",
        "id": "17"
    },
    {
        "currency": "BBD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 96497.01,
        "amount_decimal": "8",
        "id": "18"
    },
    {
        "currency": "MZN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 10938.29,
        "amount_decimal": "6",
        "id": "19"
    },
    {
        "currency": "BMD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 97968.91,
        "amount_decimal": "3",
        "id": "20"
    },
    {
        "currency": "SAR",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 54328.41,
        "amount_decimal": "8",
        "id": "21"
    },
    {
        "currency": "AED",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 70009.9,
        "amount_decimal": "1",
        "id": "22"
    },
    {
        "currency": "VND",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 37943.21,
        "amount_decimal": "1",
        "id": "23"
    },
    {
        "currency": "CUP",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 93352.5,
        "amount_decimal": "2",
        "id": "24"
    },
    {
        "currency": "BTN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 84266.43,
        "amount_decimal": "2",
        "id": "25"
    }
]
    ''';
  }
}

@JsonSerializable()
class CurrencyModelData {
  int? id;
  String? currency;
  @JSONField(name: "currency_icon")
  String? currencyIcon;
  @JSONField(name: "twd_price")
  double? twdPrice;
  @JSONField(name: "amount_decimal")
  int? amountDecimal;

  CurrencyModelData();

  factory CurrencyModelData.fromJson(Map<String, dynamic> json) => $CurrencyModelDataFromJson(json);

  Map<String, dynamic> toJson() => $CurrencyModelDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
