import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/Service/CurrencyService.dart';
import 'package:flutter_currency/Utility/RegExpUtility.dart';
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

final currencyServiceProvider = Provider<CurrencyService>((ref) => CurrencyService());

final currencyViewModel = NotifierProvider.autoDispose<CurrencyViewModel, CurrencyState>(() => CurrencyViewModel());

class CurrencyViewModel extends AutoDisposeNotifier<CurrencyState> {
  @override
  CurrencyState build() {
    service = ref.watch(currencyServiceProvider);
    return CurrencyState();
  }

  late final CurrencyService service;

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

  /// Func:匯率計算
  double calculateExchangeRate(CurrencyModelData fromCurrencyData, CurrencyModelData toCurrencyData) =>
      (fromCurrencyData.twdPrice ?? 0.0) / (toCurrencyData.twdPrice ?? 0.0);

  /// Func:計算後, 字串根據fixed化簡, 並移除小數點後都是0的字串
  String calculateExchangeRateTxt(double amount, double rate, int fixed) =>
      RegExpUtility.removeTrailingDotsZeros((amount * rate).toStringAsFixed(fixed));

  /// Func: 根據兩種貨幣TWD匯率生成匯率字串
  String getConversionRateStr(CurrencyModelData fromCurrencyData, CurrencyModelData toCurrencyData) {
    String formattedRate = RegExpUtility.removeTrailingDotsZeros(
        calculateExchangeRate(getMainCurrencyData, getSecondCurrencyData)
            .toStringAsFixed(getSecondCurrencyData.amountDecimal ?? 0));
    return "1 ${getMainCurrencyData.currency} ≈ $formattedRate ${getSecondCurrencyData.currency}";
  }

  /// API
  Future getCurrencyData() => service.getCurrencyPairs().then((value) => currencyModelData = value?.data ?? []);
}
