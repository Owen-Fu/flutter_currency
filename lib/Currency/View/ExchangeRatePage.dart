import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/View/Component/CurrencyRateWidget.dart';
import 'package:flutter_currency/Currency/View/RateConvesionPage.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_currency/Utility/ColorTable.dart';
import 'package:flutter_currency/Utility/RadiusTable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExchangeRatePage extends ConsumerStatefulWidget {
  const ExchangeRatePage({super.key});

  @override
  ConsumerState<ExchangeRatePage> createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends ConsumerState<ExchangeRatePage> {
  late CurrencyViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(currencyViewModel.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.getMockData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyModelData = ref.watch(currencyViewModel.select((state) => state.currencyModelData));
    ref.watch(currencyViewModel);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTable.appbarColor,
        title: const Text('Rate Table (TWD)'),
      ),
      body: Column(
        children: [
          titleWidget(),
          Divider(color: Colors.black, height: 1.h),
          tableWidget(currencyModelData),
          Divider(color: Colors.black, height: 1.h),
          buttonWidget(),
        ],
      ),
    );
  }

  Widget titleWidget() {
    return Container(
      height: 30.w,
      color: ColorTable.appbarColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text('Currency'), Text('Price')],
      ),
    );
  }

  Widget tableWidget(List<CurrencyModelData> currencyModelData) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15.h),
        itemCount: currencyModelData.length,
        itemBuilder: (context, index) {
          return Container(
            height: 30.h,
            margin: EdgeInsets.only(top: 15.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CurrencyRateWidget(currencyData: currencyModelData[index]),
          );
        },
      ),
    );
  }

  Widget buttonWidget() {
    return SizedBox(
      height: 120.w,
      child: Container(
        margin: EdgeInsets.only(top: 20.h, bottom: 35.h, left: 80.w, right: 80.w),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RateConvesionPage()),
          ),
          child: ClipRRect(
            borderRadius: RadiusTable.radiusTwenty,
            child: Container(
                alignment: Alignment.center,
                height: 50.w,
                color: ColorTable.appbarColor,
                child: Text(
                  'Rate Conversion',
                  style: TextStyle(fontSize: 20.sp),
                )),
          ),
        ),
      ),
    );
  }
}
