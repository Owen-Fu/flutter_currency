import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyState {
  CurrencyState({
    this.currencyModelData = const [],
    this.mainCurrencyIdx = 0,
    this.secondCurrencyIdx = 0,
  });

  final List<CurrencyModelData> currencyModelData;
  final int mainCurrencyIdx;
  final int secondCurrencyIdx;

  CurrencyState copyWith({
    List<CurrencyModelData>? currencyModelData,
    int? mainCurrencyIdx,
    int? secondCurrencyIdx,
  }) {
    return CurrencyState(
      currencyModelData: currencyModelData ?? this.currencyModelData,
      mainCurrencyIdx: mainCurrencyIdx ?? this.mainCurrencyIdx,
      secondCurrencyIdx: secondCurrencyIdx ?? this.secondCurrencyIdx,
    );
  }
}

final currencyViewModel = NotifierProvider.autoDispose<CurrencyViewModel, CurrencyState>(() => CurrencyViewModel());

class CurrencyViewModel extends AutoDisposeNotifier<CurrencyState> {
  @override
  CurrencyState build() => CurrencyState();

  TextEditingController mainCurrencyController = TextEditingController();
  TextEditingController secondCurrencyController = TextEditingController();

  void initData() {
    mainCurrencyController.text = "";
    mainCurrencyIdx = 0;
    secondCurrencyController.text = "";
    secondCurrencyIdx = (currencyModelData.length > 1) ? 1 : 0;
  }

  set currencyModelData(List<CurrencyModelData> value) => state = state.copyWith(currencyModelData: value);

  List<CurrencyModelData> get currencyModelData => state.currencyModelData;

  set mainCurrencyIdx(int value) => state = state.copyWith(mainCurrencyIdx: value);

  int get mainCurrencyIdx => state.mainCurrencyIdx;

  set secondCurrencyIdx(int value) => state = state.copyWith(secondCurrencyIdx: value);

  int get secondCurrencyIdx => state.secondCurrencyIdx;

  CurrencyModelData get getMainCurrencyData => state.currencyModelData[mainCurrencyIdx];

  CurrencyModelData get getSecondCurrencyData => state.currencyModelData[secondCurrencyIdx];

  void getMockData() {
    Map<String, dynamic> data = {"data": jsonDecode(CurrencyModel().getMockData())};
    CurrencyModel mockCurrencyModel = CurrencyModel.fromJson(data);
    currencyModelData = mockCurrencyModel.data ?? [];
  }

  void changeCurrencyIndex(bool isMainCurrency, int idx) =>
      isMainCurrency ? mainCurrencyIdx = idx : secondCurrencyIdx = idx;

  /// 匯率計算
  double calculateExchangeRate(CurrencyModelData fromCurrencyData, CurrencyModelData toCurrencyData) =>
      (fromCurrencyData.twdPrice ?? 0.0) / (toCurrencyData.twdPrice ?? 0.0);

  String calculateExchangeRateTxt(double value, double rate, int fixed) =>
      (value * rate).toStringAsFixed(fixed).replaceFirst(RegExp(r'\.?0+$'), '');

  /// 根據兩種貨幣TWD匯率生成字串
  String getConversionRateStr(CurrencyModelData fromCurrencyData, CurrencyModelData toCurrencyData) {
    String formattedRate = calculateExchangeRate(getMainCurrencyData, getSecondCurrencyData)
        .toStringAsFixed(getSecondCurrencyData.amountDecimal ?? 0);
    return "1 ${getMainCurrencyData.currency} ≈ $formattedRate ${getSecondCurrencyData.currency}";
  }
}
