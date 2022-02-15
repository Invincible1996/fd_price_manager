///
/// @date: 2022/2/14 13:44
/// @author: kevin
/// @description: dart
import 'package:flutter/material.dart';

import '../m_colors.dart';

class AssemblePricePage extends StatefulWidget {
  const AssemblePricePage({Key? key}) : super(key: key);

  @override
  _AssemblePricePageState createState() => _AssemblePricePageState();
}

class _AssemblePricePageState extends State<AssemblePricePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'AssemblePricePage',
          style: TextStyle(color: MColors.textColor),
        ),
      ),
      body: Container(
        color: MColors.bgColor,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
