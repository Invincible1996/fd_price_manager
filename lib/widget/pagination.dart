///
/// @date: 2022/2/23 16:13
/// @author: kevin
/// @description: dart
import 'package:fd_price_manager/util/log.dart';
import 'package:fd_price_manager/widget/page_size_select.dart';
import 'package:flutter/material.dart';

import '../m_colors.dart';

enum PageIndexType {
  number,
  dot,
}

class Pagination extends StatefulWidget {
  final int currentPage;

  final int totalCount;

  final Function(int, int)? onPageChanged;

  const Pagination({
    Key? key,
    this.currentPage = 0,
    required this.totalCount,
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
  }

  didUpdateWidget(Pagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果totalCount发生变化，需要设置当前页为0
    if (oldWidget.totalCount != widget.totalCount) {
      _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    log('totalCount: ${widget.totalCount}');

    totalGroupSize = (widget.totalCount / pageSize).ceilToDouble().toInt();
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
                  border: Border.all(color: _selectedIndex == 0 ? MColors.disabledColor : MColors.divideColor),
                ),
                child: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 22,
                  color: _selectedIndex == 0 ? MColors.disabledColor : MColors.textColor,
                ),
              ),
              onTap: _selectedIndex == 0
                  ? null
                  : () {
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
                child: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 22,
                  color: _selectedIndex == totalGroupSize - 1 ? MColors.disabledColor : MColors.textColor,
                ),
              ),
              onTap: _selectedIndex == totalGroupSize - 1
                  ? null
                  : () {
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
          PageSizeSelect(
            pageSizeList: [10, 20, 30, 50, 100],
            onPageSizeChanged: (int value) {
              log(value);
              setState(() {
                pageSize = value;
                _selectedIndex = 0;
              });
              widget.onPageChanged?.call(_selectedIndex, pageSize);
            },
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
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: MColors.divideColor),
        ),
        child: Text('${(_selectedIndex) * pageSize + 1}-${(pageSize * (_selectedIndex + 1)) > widget.totalCount ? widget.totalCount : pageSize * (_selectedIndex + 1)} 共${widget.totalCount}'));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
