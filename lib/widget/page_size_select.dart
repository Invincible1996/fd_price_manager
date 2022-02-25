///
/// @date: 2022/2/25 14:43
/// @author: kevin
/// @description: dart
///
import 'package:fd_price_manager/m_colors.dart';
import 'package:fd_price_manager/widget/custom_dialog.dart';
import 'package:flutter/material.dart';

import '../util/log.dart';

class PageSizeSelect extends StatefulWidget {
  final List<int> pageSizeList;

  final Function(int) onPageSizeChanged;

  const PageSizeSelect({
    Key? key,
    required this.pageSizeList,
    required this.onPageSizeChanged,
  }) : super(key: key);

  @override
  _PageSizeSelectState createState() => _PageSizeSelectState();
}

class _PageSizeSelectState extends State<PageSizeSelect> {
  int _pageSize = 10;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          _showSelect(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 3,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: MColors.divideColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Text('$_pageSize条/页'),
              Icon(Icons.arrow_drop_down_sharp),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showSelect(BuildContext context) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double x = position.dx;
    double y = position.dy;
    print('x===========$x');
    print('y============$y');
    final size = box.size;
    log(size.height);
    log(size.width);

    showCustomDialog(
      context,
      Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              bottom: size.height + 10,
              left: x,
              child: Container(
                width: size.width,
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      // offset: Offset(-1, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                constraints: BoxConstraints(
                  maxHeight: 150,
                ),
                // color: Colors.red,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.pageSizeList
                        .map(
                          (e) => Material(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _pageSize = e;
                                });
                                widget.onPageSizeChanged(e);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text('$e'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
