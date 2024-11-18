import 'dart:convert';

import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/Service/CurrencyService.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../AppTest.dart';
import 'CurrencyViewModel_test.mocks.dart';

@GenerateMocks([CurrencyModel, CurrencyService])
void main() {
  late ProviderContainer container;
  late CurrencyViewModel viewModel;
  late CurrencyModel currencyModel;

  late List<CurrencyModelData> testData = [
    CurrencyModelData(currency: 'USD', twdPrice: 30.0, amountDecimal: 2),
    CurrencyModelData(currency: 'EUR', twdPrice: 15.0, amountDecimal: 2),
  ];

  AppTest.testSetUpAll();

  setUp(() {
    container = ProviderContainer(overrides: [
      currencyServiceProvider.overrideWithValue(MockCurrencyService()),
    ]);
    viewModel = container.read(currencyViewModel.notifier);
    currencyModel = CurrencyModel.fromJson({"data": jsonDecode(CurrencyModel().getMockData())});
  });

  tearDown(() {
    container.dispose();
  });

  group('CurrencyViewModel Tests', () {
    test('Initial state should be empty', () {
      expect(viewModel.currencyModelData, isEmpty);
      expect(viewModel.mainCurrencyIdx, 0);
      expect(viewModel.secondCurrencyIdx, 0);
    });

    test('clearText', () {
      viewModel.mainCurrencyController.text = "test1";
      viewModel.secondCurrencyController.text = "test2";
      viewModel.clearText();
      expect(viewModel.mainCurrencyController.text, '');
      expect(viewModel.secondCurrencyController.text, '');
    });
    group('initData()', () {
      test('no data', () {
        viewModel.initData();
        expect(viewModel.currencyModelData, isEmpty);
        expect(viewModel.mainCurrencyIdx, 0);
        expect(viewModel.secondCurrencyIdx, 0);
        expect(viewModel.mainCurrencyController.text, "");
        expect(viewModel.secondCurrencyController.text, "");
      });

      test('set data and reset', () {
        viewModel.currencyModelData = testData;
        viewModel.initData();
        expect(viewModel.currencyModelData, isNotEmpty);
        expect(viewModel.mainCurrencyIdx, 0);
        expect(viewModel.secondCurrencyIdx, 1);
        expect(viewModel.mainCurrencyController.text, "");
        expect(viewModel.secondCurrencyController.text, "");
      });
    });

    group('getConversionRateStr()', () {
      test('', () {
        viewModel.currencyModelData = testData;
        viewModel.mainCurrencyIdx = 0;
        viewModel.secondCurrencyIdx = 1;
        String str = viewModel.getConversionRateStr();
        expect(str, '1 USD ≈ 2 EUR');
      });

      test('', () {
        viewModel.currencyModelData = testData;
        viewModel.mainCurrencyIdx = 0;
        viewModel.secondCurrencyIdx = 1;
        String str = viewModel.getConversionRateStr();
        expect(str, '1 USD ≈ 2 EUR');
      });
    });

    group('service.getCurrencyPairs()', () {
      test('API success', () async {
        when(viewModel.service.getCurrencyPairs()).thenAnswer((_) async => currencyModel);
        await viewModel.getCurrencyData().then((value) {
          expect(viewModel.currencyModelData, isNotEmpty);
          expect(viewModel.currencyModelData.length, 25);
          expect(viewModel.currencyModelData[0].currency, 'OMR');
          expect(viewModel.currencyModelData[1].currency, 'NZD');
        });
      });

      test('API error', () async {
        when(viewModel.service.getCurrencyPairs()).thenThrow(Exception('API Error'));
        expect(() async => await viewModel.getCurrencyData(), throwsException);
      });
    });
  });
}
