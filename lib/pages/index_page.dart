///
/// @date: 2022/2/14 13:35
/// @author: kevin
/// @description: dart
///
import 'package:flutter/material.dart';

import '../m_colors.dart';
import '../service/database_helper.dart';
import 'assemble_price_page.dart';
import 'product_list_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<Widget> _pages = [
    const ProductListPage(),
    const AssemblePricePage(),
  ];

  final PageController _controller = PageController();

  int _selectIndex = 0;

  @override
  initState() {
    super.initState();
    var databaseHelper = DatabaseHelper();
    databaseHelper.initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('IndexPage')),
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Container(
              width: 200,
              // color: Colors.red,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1,
                    color: MColors.divideColor,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xFFe6e6e6),
                        ),
                      ),
                    ),
                    child: const Text(
                      'FD Price Manager',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = 0;
                        _controller.jumpToPage(0);
                      });
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: _selectIndex == 0 ? MColors.primaryColor : Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.list_alt_sharp,
                            color: _selectIndex == 0 ? Colors.white : MColors.textColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '?????????????????????',
                            style: TextStyle(color: _selectIndex == 0 ? Colors.white : MColors.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectIndex = 1;
                        _controller.jumpToPage(1);
                      });
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: _selectIndex == 1 ? MColors.primaryColor : Colors.transparent,
                      child: Row(
                        children: [
                          Icon(
                            Icons.list_alt_sharp,
                            color: _selectIndex == 1 ? Colors.white : MColors.textColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '????????????',
                            style: TextStyle(color: _selectIndex == 1 ? Colors.white : MColors.textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: PageView.builder(
                  controller: _controller,
                  itemBuilder: (_, index) => _pages[index],
                  itemCount: _pages.length,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
