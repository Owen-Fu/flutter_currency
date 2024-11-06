import 'dart:convert';

import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyState {
  CurrencyState({
    this.currencyModelData = const [],
  });

  List<CurrencyModelData> currencyModelData;

  CurrencyState copyWith({
    List<CurrencyModelData>? currencyModelData,
  }) {
    return CurrencyState(
      currencyModelData: currencyModelData ?? this.currencyModelData,
    );
  }
}

final currencyViewModel = NotifierProvider.autoDispose<CurrencyViewModel, CurrencyState>(() => CurrencyViewModel());

class CurrencyViewModel extends AutoDisposeNotifier<CurrencyState> {
  @override
  CurrencyState build() => CurrencyState();

  set currencyModelData(List<CurrencyModelData> value) => state = state.copyWith(currencyModelData: value);

  List<CurrencyModelData> get currencyModelData => state.currencyModelData;

  void getMockData() {
    Map<String, dynamic> data = {"data": jsonDecode(CurrencyModel().getMockData())};
    CurrencyModel mockCurrencyModel = CurrencyModel.fromJson(data);
    currencyModelData = mockCurrencyModel.data ?? [];
  }
}
