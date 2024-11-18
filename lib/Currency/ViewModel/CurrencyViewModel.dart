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

  void clearText() {
    mainCurrencyController.text = "";
    secondCurrencyController.text = "";
  }

  set currencyModelData(List<CurrencyModelData> value) => state = state.copyWith(currencyModelData: value);

  List<CurrencyModelData> get currencyModelData => state.currencyModelData;

  set mainCurrencyIdx(int value) => state = state.copyWith(mainCurrencyIdx: value);

  int get mainCurrencyIdx => state.mainCurrencyIdx;

  set secondCurrencyIdx(int value) => state = state.copyWith(secondCurrencyIdx: value);

  int get secondCurrencyIdx => state.secondCurrencyIdx;

  CurrencyModelData get getMainCurrencyData => state.currencyModelData[mainCurrencyIdx];

  CurrencyModelData get getSecondCurrencyData => state.currencyModelData[secondCurrencyIdx];

  String getConversionRateStr() => getMainCurrencyData.getConversionRateStr(secondCurrency: getSecondCurrencyData);

  /// API
  Future getCurrencyData() => service.getCurrencyPairs().then((value) => currencyModelData = value?.data ?? []);
}
