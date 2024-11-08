import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/View/Component/CurrencySelectWidget.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_currency/Utility/ColorUtility.dart';
import 'package:flutter_currency/Utility/IconUtility.dart';
import 'package:flutter_currency/Utility/RadiusUtility.dart';
import 'package:flutter_currency/Utility/RegExpUtility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateConversionPage extends ConsumerStatefulWidget {
  const RateConversionPage({super.key});

  @override
  ConsumerState<RateConversionPage> createState() => _RateConversionPageState();
}

class _RateConversionPageState extends ConsumerState<RateConversionPage> {
  late CurrencyViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(currencyViewModel.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(currencyViewModel);
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorUtility.appbarColor,
              title: const Text('Rate Conversion'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                margin: EdgeInsets.only(top: 15.h),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: RadiusUtility.radiusTwenty,
                      child: Container(
                          alignment: Alignment.center,
                          height: 200.h,
                          color: ColorUtility.appbarColor,
                          child: Column(
                            children: [
                              currencySelect(
                                  controller: _viewModel.mainCurrencyController,
                                  data: _viewModel.getMainCurrencyData,
                                  onTap: onMainCurrencyTap,
                                  selectIndex: _viewModel.mainCurrencyIdx,
                                  onTextChange: onMainCurrencyTextChange),
                              const Divider(color: Colors.black),
                              currencySelect(
                                  controller: _viewModel.secondCurrencyController,
                                  data: _viewModel.getSecondCurrencyData,
                                  onTap: onSecondCurrencyTap,
                                  selectIndex: _viewModel.secondCurrencyIdx,
                                  readOnly: true),
                            ],
                          )),
                    ),
                    conversionRateText(),
                    downArrowIcon(),
                  ],
                ))));
  }

  Widget currencySelect({
    required TextEditingController controller,
    required CurrencyModelData data,
    required ValueChanged<int> onTap,
    required int selectIndex,
    bool readOnly = false,
    Function(String)? onTextChange,
  }) {
    return Expanded(
      flex: 1,
      child: CurrencySelectWidget(
        textController: controller,
        data: data,
        onTap: onTap,
        selectIndex: selectIndex,
        readOnly: readOnly,
        onTextChange: onTextChange,
      ),
    );
  }

  Widget conversionRateText() {
    return Positioned(
      top: 80.h,
      right: 30.w,
      child: Text(_viewModel.getConversionRateStr(_viewModel.getMainCurrencyData, _viewModel.getSecondCurrencyData)),
    );
  }

  Widget downArrowIcon() {
    return Positioned(
      top: 80.h,
      left: 50.w,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            color: Colors.black,
            child: Icon(
              IconUtility.downArrow,
              color: Colors.white,
              size: 40.w,
            ),
          )),
    );
  }

  void onMainCurrencyTap(int idx) {
    _viewModel.mainCurrencyIdx = idx;
    reCalculate(_viewModel.mainCurrencyController.text);
  }

  void onSecondCurrencyTap(int idx) {
    _viewModel.secondCurrencyIdx = idx;
    reCalculate(_viewModel.mainCurrencyController.text);
  }

  void onMainCurrencyTextChange(String txt) {
    if (txt.isEmpty) _viewModel.secondCurrencyController.text = "";
    if (!RegExpUtility.isValidDecimal(txt)) return;
    _viewModel.secondCurrencyController.text = _viewModel.calculateExchangeRateTxt(
        double.parse(txt),
        _viewModel.calculateExchangeRate(_viewModel.getMainCurrencyData, _viewModel.getSecondCurrencyData),
        _viewModel.getSecondCurrencyData.amountDecimal ?? 0);
  }

  void reCalculate(String txt) {
    if (_viewModel.secondCurrencyController.text.isEmpty) return;

    final double amount = double.parse(txt);
    final double exchangeRate =
        _viewModel.calculateExchangeRate(_viewModel.getMainCurrencyData, _viewModel.getSecondCurrencyData);
    final int decimal = _viewModel.getSecondCurrencyData.amountDecimal ?? 0;

    _viewModel.secondCurrencyController.text = _viewModel.calculateExchangeRateTxt(amount, exchangeRate, decimal);
  }
}
