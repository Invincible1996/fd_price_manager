///
/// @date: 2022/2/15 14:51
/// @author: kevin
/// @description: dart
///
import 'package:flutter/material.dart';

import '../m_colors.dart';
import '../util/log.dart';
import 'custom_dialog.dart';

///
enum SelectType {
  search,
  custom,
}

///
///
enum MenuType {
  list,
  wrap,
}

class Select<T> extends StatefulWidget {
  final Function(T) onItemSelected;
  final List<T> options;
  final double width;
  final SelectType type;
  final MenuType menuType;
  final Function(T)? onSearch;
  final T? defaultValue;

  const Select({
    Key? key,
    required this.menuType,
    required this.onItemSelected,
    required this.options,
    required this.width,
    required this.type,
    this.onSearch,
    this.defaultValue,
  }) : super(key: key);

  @override
  State<Select<T>> createState() => _SelectState<T>();
}

class _SelectState<T> extends State<Select<T>> {
  T? selectValue;

  TextEditingController controller = TextEditingController();

  var focusNode = FocusNode();

  @override
  initState() {
    super.initState();
    selectValue = widget.defaultValue;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        log('object');
        _showSelect(context);
      } else {}
    });
  }

  ///
  /// @desc
  ///
  _showSelect(BuildContext context) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double x = position.dx;
    double y = position.dy;
    // print(x);
    // print(y);
    final size = box.size;
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
            _buildMenu(context, x, y, size),
          ],
        ),
      ),
    );
  }

  ///
  /// @desc
  ///
  _buildMenu(BuildContext context, x, y, size) {
    switch (widget.menuType) {
      case MenuType.list:
        return Positioned(
          top: y + size.height + 6,
          left: x,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: 150,
            ),
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: widget.options
                    .map((e) => Material(
                          color: Colors.white,
                          child: InkWell(
                            focusColor: Colors.white,
                            hoverColor: const Color(0xFFF3F3F3),
                            onTap: () {
                              setState(() {
                                selectValue = e;
                              });
                              if (widget.type == SelectType.search) {
                                controller.text = '$e';
                                FocusScope.of(context).unfocus();
                              }
                              widget.onItemSelected(e);
                              Navigator.pop(context);
                            },
                            child: Container(
                              // color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('$e'),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
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
          ),
        );
      case MenuType.wrap:
        return Positioned(
          top: y + size.height + 6,
          left: x,
          child: Container(
            // constraints: BoxConstraints(
            //   maxHeight: 150,
            // ),
            padding: EdgeInsets.all(8),
            width: 340,
            child: Wrap(
              direction: Axis.horizontal,
              children: widget.options
                  .map((e) => Material(
                        color: Colors.white,
                        child: InkWell(
                          focusColor: Colors.white,
                          hoverColor: const Color(0xFFF3F3F3),
                          onTap: () {
                            setState(() {
                              selectValue = e;
                            });
                            if (widget.type == SelectType.search) {
                              controller.text = '$e';
                              FocusScope.of(context).unfocus();
                            }
                            widget.onItemSelected(e);
                            Navigator.pop(context);
                          },
                          child: Container(
                            // color: Colors.white,
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$e'),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  // offset: Offset(-1, 4),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          _showSelect(context);
        },
        child: _buildSelect(context, widget.type),
      ),
    );
  }

  ///
  /// @param [context]
  /// @param [type]
  /// @return Widget
  ///
  _buildSelect(BuildContext context, SelectType type) {
    switch (type) {
      case SelectType.search:
        return Container(
          constraints: BoxConstraints(
            maxWidth: 150,
          ),
          child: TextFormField(
            onChanged: (value) {
              log(value);
            },
            controller: controller,
            // initialValue: selectValue,
            focusNode: focusNode,
            decoration: const InputDecoration(
              hintText: 'placeholderText',
              hintStyle: TextStyle(fontSize: 14),
              contentPadding: EdgeInsets.all(10),
              isDense: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: MColors.primaryColor,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.teal,
                  width: 1,
                ),
              ),
            ),
          ),
        );
      case SelectType.custom:
        return Container(
          width: widget.width,
          // constraints: BoxConstraints(
          //   minWidth: 60,
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$selectValue'),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color(0xFFC4C4C4),
              width: 1,
            ),
          ),
        );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
