import 'dart:convert';

import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/Service/CurrencyService.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'AppTest.dart';
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
        String str = viewModel.getConversionRateStr(viewModel.getMainCurrencyData, viewModel.getSecondCurrencyData);
        expect(str, '1 USD ≈ 2 EUR');
      });

      test('', () {
        viewModel.currencyModelData = testData;
        viewModel.mainCurrencyIdx = 0;
        viewModel.secondCurrencyIdx = 1;
        String str = viewModel.getConversionRateStr(viewModel.getMainCurrencyData, viewModel.getSecondCurrencyData);
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

    group('calculateExchangeRateTxt()', () {
      test('Basic conversion with fixed decimal places', () {
        double amount = 100.0;
        double rate = 1.2345;
        int fixed = 2;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '123.45');
      });

      test('Remove trailing zeros after decimal point', () {
        double amount = 50.0;
        double rate = 2.5000;
        int fixed = 4;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '125');
      });

      test('Fixed decimal places is zero', () {
        double amount = 80.0;
        double rate = 1.75;
        int fixed = 0;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '140');
      });

      test('Fixed decimal places greater than actual decimals', () {
        double amount = 20.0;
        double rate = 3.1;
        int fixed = 3;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '62');
      });

      test('Negative amount and rate', () {
        double amount = -50.0;
        double rate = -2.0;
        int fixed = 2;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '100');
      });

      test('Zero amount', () {
        double amount = 0.0;
        double rate = 5.5;
        int fixed = 2;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '0');
      });

      test('Zero rate', () {
        double amount = 100.0;
        double rate = 0.0;
        int fixed = 2;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '0');
      });

      test('Large numbers', () {
        double amount = 1e6;
        double rate = 1.2345;
        int fixed = 2;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '1234500');
      });

      test('Small numbers with many decimal places', () {
        double amount = 0.0001;
        double rate = 0.0002;
        int fixed = 8;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);

        expect(result, '0.00000002');
      });

      test('Trailing decimal point removal when necessary', () {
        double amount = 10.0;
        double rate = 1.0;
        int fixed = 2;
        String result = viewModel.calculateExchangeRateTxt(amount, rate, fixed);
        expect(result, '10');
      });
    });
  });
}
