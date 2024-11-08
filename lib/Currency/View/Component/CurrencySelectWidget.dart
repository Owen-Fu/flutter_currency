import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_currency/Currency/Model/CurrencyModel.dart';
import 'package:flutter_currency/Currency/View/SelectCurrencyPage.dart';
import 'package:flutter_currency/Utility/IconUtility.dart';
import 'package:flutter_currency/Utility/RadiusUtility.dart';
import 'package:flutter_currency/Utility/RegExpUtility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencySelectWidget extends StatelessWidget {
  const CurrencySelectWidget({
    super.key,
    this.onTap,
    this.selectIndex = 0,
    required this.data,
    this.readOnly = false,
    this.textController,
    this.onTextChange,
  });

  final ValueChanged<int>? onTap;
  final int selectIndex;
  final CurrencyModelData data;
  final bool readOnly;
  final TextEditingController? textController;
  final ValueChanged<String>? onTextChange;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      selectCurrencyWidget(context),
      SizedBox(width: 30.w),
      inputWidget(),
    ]);
  }

  Widget selectCurrencyWidget(BuildContext context) {
    return ClipRRect(
        borderRadius: RadiusUtility.radiusTen,
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectCurrencyPage(selectIndex: selectIndex, onTapCallBack: (index) => onTap?.call(index))),
          ),
          child: Container(
            height: 40.h,
            width: 120.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  width: 30.w,
                  height: 30.h,
                  imageUrl: data.currencyIcon ?? '',
                  errorWidget: (context, url, error) => const Icon(Icons.crop_square, size: 30),
                  fit: BoxFit.cover,
                ),
                Text(data.currency ?? ''),
                const Icon(IconUtility.downArrow, size: 20),
              ],
            ),
          ),
        ));
  }

  Widget inputWidget() {
    return SizedBox(
        width: 120.w,
        height: 40.h,
        child: TextField(
          style: TextStyle(fontSize: 12.sp),
          magnifierConfiguration: TextMagnifierConfiguration.disabled,
          textAlign: TextAlign.right,
          onChanged: onTextChange,
          controller: textController,
          readOnly: readOnly,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExpUtility.decimalInputFormatter),
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ));
  }
}
