import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CurrencyRateWidget extends StatelessWidget {
  const CurrencyRateWidget({super.key, required this.currencyData, this.isTablePage = true, this.isSelected = false});

  final bool isTablePage;
  final bool isSelected;
  final CurrencyModelData currencyData;

  @override
  Widget build(BuildContext context) {
    String currencyTitle = isTablePage ? "${currencyData.currency ?? ""}/TWD" : currencyData.currency ?? "";
    String priceString = NumberFormat('#,##0.00').format(currencyData.twdPrice);
    TextStyle textStyle = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);

    return Row(children: [
      Expanded(
          flex: 2,
          child: Row(
            children: [
              SizedBox(
                width: 30.w,
                height: 30.h,
                child: currencyIcon(),
              ),
              SizedBox(width: 8.w),
              Text(currencyTitle, style: textStyle),
            ],
          )),
      Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: isTablePage
                ? Text(
                    priceString,
                    style: textStyle,
                  )
                : checkIcon(),
          ))
    ]);
  }

  Widget? checkIcon() => isSelected ? const Icon(Icons.check) : null;

  Widget currencyIcon() {
    return CachedNetworkImage(
      imageUrl: currencyData.currencyIcon ?? '',
      errorWidget: (context, url, error) => const Icon(Icons.crop_square, size: 30),
      width: 30.w,
      height: 30.h,
      fit: BoxFit.cover,
    );
  }
}
