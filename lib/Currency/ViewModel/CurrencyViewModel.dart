import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/Service/CurrencyService.dart';
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

  final CurrencyService _service = CurrencyService();

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

  void changeCurrencyIndex(bool isMainCurrency, int idx) =>
      isMainCurrency ? mainCurrencyIdx = idx : secondCurrencyIdx = idx;

  /// Func:匯率計算
  double calculateExchangeRate(CurrencyModelData fromCurrencyData, CurrencyModelData toCurrencyData) =>
      (fromCurrencyData.twdPrice ?? 0.0) / (toCurrencyData.twdPrice ?? 0.0);

  /// Func:數字轉換化簡
  String calculateExchangeRateTxt(double amount, double rate, int fixed) =>
      (amount * rate).toStringAsFixed(fixed).replaceFirst(RegExp(r'\.?0+$'), '');

  /// Func: 根據兩種貨幣TWD匯率生成匯率字串
  String getConversionRateStr(CurrencyModelData fromCurrencyData, CurrencyModelData toCurrencyData) {
    String formattedRate = calculateExchangeRate(getMainCurrencyData, getSecondCurrencyData)
        .toStringAsFixed(getSecondCurrencyData.amountDecimal ?? 0);
    return "1 ${getMainCurrencyData.currency} ≈ $formattedRate ${getSecondCurrencyData.currency}";
  }

  /// API
  Future getCurrencyData() => _service.getCurrencyPairs().then((value) => currencyModelData = value?.data ?? []);
}
