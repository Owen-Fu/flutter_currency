import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/View/Component/CurrencyRateWidget.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_currency/Utility/ColorUtility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCurrencyPage extends ConsumerWidget {
  const SelectCurrencyPage({super.key, this.selectIndex = 0, this.onTapCallBack});

  final int selectIndex;
  final ValueChanged<int>? onTapCallBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorUtility.appbarColor,
        title: const Text('Currency Select'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: tableWidget(ref.read(currencyViewModel.notifier).currencyModelData),
      )),
    );
  }

  Widget tableWidget(List<CurrencyModelData> currencyModelData) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Container(height: 1, color: Colors.grey),
      itemCount: currencyModelData.length,
      itemBuilder: (context, index) {
        return Container(
          height: 30.h,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              onTapCallBack?.call(index);
              Navigator.pop(context);
            },
            child: CurrencyRateWidget(
              currencyData: currencyModelData[index],
              isTablePage: false,
              isSelected: selectIndex == index,
            ),
          ),
        );
      },
    );
  }
}
