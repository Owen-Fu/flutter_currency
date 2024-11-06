import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/View/Component/CurrencySelectWidget.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_currency/Utility/ColorUtility.dart';
import 'package:flutter_currency/Utility/RadiusUtility.dart';
import 'package:flutter_currency/Utility/RegExpUtility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RateConvesionPage extends ConsumerStatefulWidget {
  const RateConvesionPage({super.key});

  @override
  ConsumerState<RateConvesionPage> createState() => _RateConvesionPageState();
}

class _RateConvesionPageState extends ConsumerState<RateConvesionPage> {
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
                              Expanded(
                                flex: 1,
                                child: CurrencySelectWidget(
                                    textController: _viewModel.mainCurrencyController,
                                    data: _viewModel.getMainCurrencyData,
                                    onTap: (idx) {
                                      _viewModel.mainCurrencyIdx = idx;
                                      reCalculate(_viewModel.mainCurrencyController.text);
                                    },
                                    selectIndex: _viewModel.mainCurrencyIdx,
                                    onTextChange: (txt) {
                                      if (txt.isEmpty) _viewModel.secondCurrencyController.text = "";
                                      if (!RegExpUtility.isValidDecimal(txt)) return;
                                      _viewModel.secondCurrencyController.text = _viewModel.calculateExchangeRateTxt(
                                          double.parse(txt),
                                          _viewModel.calculateExchangeRate(
                                              _viewModel.getMainCurrencyData, _viewModel.getSecondCurrencyData),
                                          _viewModel.getSecondCurrencyData.amountDecimal ?? 0);
                                    }),
                              ),
                              const Divider(color: Colors.black),
                              Expanded(
                                flex: 1,
                                child: CurrencySelectWidget(
                                  readOnly: true,
                                  textController: _viewModel.secondCurrencyController,
                                  data: _viewModel.getSecondCurrencyData,
                                  onTap: (idx) {
                                    _viewModel.secondCurrencyIdx = idx;
                                    reCalculate(_viewModel.mainCurrencyController.text);
                                  },
                                  selectIndex: _viewModel.secondCurrencyIdx,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Positioned(
                      top: 80.h,
                      right: 30.w,
                      child: Text(_viewModel.getConversionRateStr(
                          _viewModel.getMainCurrencyData, _viewModel.getSecondCurrencyData)),
                    ),
                    Positioned(
                      top: 80.h,
                      left: 50.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            color: Colors.black,
                            child: Icon(
                              const IconData(0xf0627, fontFamily: 'MaterialIcons'),
                              color: Colors.white,
                              size: 40.w,
                            ),
                          )),
                    )
                  ],
                ))));
  }

  void reCalculate(String txt) {
    _viewModel.secondCurrencyController.text = _viewModel.calculateExchangeRateTxt(
        double.parse(txt),
        _viewModel.calculateExchangeRate(_viewModel.getMainCurrencyData, _viewModel.getSecondCurrencyData),
        _viewModel.getSecondCurrencyData.amountDecimal ?? 0);
  }
}
