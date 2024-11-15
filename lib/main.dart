import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/Currency/View/ExchangeRatePage.dart';
import 'package:flutter_currency/Utility/Net/requester.dart';
import 'package:flutter_currency/generated/json/base/json_convert_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
            appBarTheme: const AppBarTheme(scrolledUnderElevation: 0.0),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Requester(isShowLog: kDebugMode);
    Requester.ins.respParser = (type, response) {
      return (jsonConvert.convertFuncMap[type.toString()])?.call((response.data ?? {}));
    };
  }

  @override
  Widget build(BuildContext context) {
    return const ExchangeRatePage();
  }
}
