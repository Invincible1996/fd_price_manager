import 'package:fd_price_manager/pages/index_page.dart';
import 'package:fd_price_manager/m_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MColors.primaryColor,
      ),
      home: const IndexPage(),
    );
  }
}
