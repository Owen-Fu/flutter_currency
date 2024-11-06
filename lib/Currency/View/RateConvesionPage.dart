import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/ViewModel/CurrencyViewModel.dart';
import 'package:flutter_currency/Utility/ColorTable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RateConvesionPage extends ConsumerStatefulWidget {
  const RateConvesionPage({super.key});

  @override
  ConsumerState<RateConvesionPage> createState() => _RateConvesionPageState();
}

class _RateConvesionPageState extends ConsumerState<RateConvesionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(currencyViewModel);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorTable.appbarColor,
          title: const Text('Rate Conversion'),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Column(
          children: [Text('1234')],
        ));
  }
}
