import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/View/Component/CurrencyRateWidget.dart';
import 'package:flutter_currency/Currency/View/RateConvesionPage.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_currency/Utility/ColorUtility.dart';
import 'package:flutter_currency/Utility/RadiusUtility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExchangeRatePage extends ConsumerStatefulWidget {
  const ExchangeRatePage({super.key});

  @override
  ConsumerState<ExchangeRatePage> createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends ConsumerState<ExchangeRatePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(currencyViewModel.notifier).getMockData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyModelData = ref.watch(currencyViewModel.select((state) => state.currencyModelData));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtility.appbarColor,
        title: const Text('Rate Table (TWD)'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          titleWidget(),
          Divider(color: Colors.black, height: 1.h),
          tableWidget(currencyModelData),
          Divider(color: Colors.black, height: 1.h),
          buttonWidget(currencyModelData),
        ],
      ),
    );
  }

  Widget titleWidget() {
    return Container(
      height: 30.h,
      color: ColorUtility.appbarColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text('Currency'), Text('Price')],
      ),
    );
  }

  Widget tableWidget(List<CurrencyModelData> currencyModelData) {
    return Expanded(
        child: ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 25.h),
      itemCount: currencyModelData.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CurrencyRateWidget(currencyData: currencyModelData[index]),
        );
      },
    ));
  }

  Widget buttonWidget(List<CurrencyModelData> currencyModelData) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 35.h, left: 80.w, right: 80.w),
      child: GestureDetector(
        onTap: () => (currencyModelData.isNotEmpty)
            ? Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RateConvesionPage()),
              )
            : null,
        child: ClipRRect(
          borderRadius: RadiusUtility.radiusTwenty,
          child: Container(
              alignment: Alignment.center,
              height: 50.h,
              color: ColorUtility.appbarColor,
              child: Text(
                'Rate Conversion',
                style: TextStyle(fontSize: 20.sp),
              )),
        ),
      ),
    );
  }
}
