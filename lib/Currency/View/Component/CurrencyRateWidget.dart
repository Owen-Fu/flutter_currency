import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CurrencyRateWidget extends StatelessWidget {
  CurrencyRateWidget({super.key, required this.currencyData});

  CurrencyModelData currencyData;

  @override
  Widget build(BuildContext context) {
    String currencyTitle = "${currencyData.currency ?? ""}/TWD";
    String priceString = NumberFormat('#,##0.00').format(currencyData.twdPrice);
    return Row(children: [
      Expanded(
          flex: 2,
          child: Row(
            children: [
              SizedBox(
                width: 30.w,
                height: 30.h,
                child: CachedNetworkImage(
                  imageUrl: currencyData.currencyIcon ?? '',
                  // placeholder: (context, url) => CircularProgressIndicator(),
                  // errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 5.w),
              Text(currencyTitle),
            ],
          )),
      Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(priceString),
          )),
    ]);
  }
}
