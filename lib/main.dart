import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/home_screen.dart';
import 'viewModel/earnings_view_model.dart';
import 'helper/global.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => EarningsViewModel(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      home: const HomeScreen(),
    );
  }
}
