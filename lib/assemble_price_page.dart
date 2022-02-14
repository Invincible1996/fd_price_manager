///
/// @date: 2022/2/14 13:44
/// @author: kevin
/// @description: dart
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('AssemblePricePage')),
      body: Container(
        color: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
