///
/// @date: 2022/2/23 16:13
/// @author: kevin
/// @description: dart
import 'package:fd_price_manager/util/log.dart';
import 'package:flutter/material.dart';

import '../m_colors.dart';

enum PageIndexType {
  number,
  dot,
}

class Pagination extends StatefulWidget {
  final int currentPage;

  final int totalPage;

  final Function(int, int)? onPageChanged;

  const Pagination({
    Key? key,
    this.currentPage = 0,
    required this.totalPage,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _PaginationState createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int _selectedIndex = 0;

  int pageSize = 10;

  int totalGroupSize = 0;

  bool _isHover = false;

  @override
  initState() {
    super.initState();
    _selectedIndex = widget.currentPage;
    totalGroupSize = (widget.totalPage / pageSize).ceilToDouble().toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: MColors.divideColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: MColors.divideColor),
                ),
                child: const Icon(Icons.keyboard_arrow_left_rounded, size: 22),
              ),
              onTap: () {
                if (_selectedIndex == 0) {
                  return;
                }
                setState(() {
                  _selectedIndex--;
                });
                widget.onPageChanged?.call(_selectedIndex, pageSize);
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          _buildPageIndexView(),
          const SizedBox(
            width: 10,
          ),
          Material(
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: MColors.divideColor),
                ),
                child: const Icon(Icons.keyboard_arrow_right_rounded, size: 22),
              ),
              onTap: () {
                if (_selectedIndex == totalGroupSize - 1) {
                  return;
                }
                setState(() {
                  _selectedIndex++;
                });
                widget.onPageChanged?.call(_selectedIndex, pageSize);
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Material(
            child: InkWell(
              onTap: () {},
              child: Container(
                // width: 100
                padding: const EdgeInsets.all(4),
                height: 30,
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                  color: MColors.divideColor,
                  // color: MColors.primaryColor,
                )),
                child: Row(
                  children: [
                    Text('$pageSize条/页'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  ///
  ///
  ///
  _buildPageIndexView() {
    log('totalGroupSize====$totalGroupSize');
    if (totalGroupSize <= 5) {
      return Wrap(
        children: List.generate(
          totalGroupSize,
          (index) => Text('${index + 1}'),
        ),
      );
    } else {
      // 大于5
      // 判断current page

      return SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
