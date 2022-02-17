///
/// @date: 2022/2/15 14:51
/// @author: kevin
/// @description: dart
///
import 'package:flutter/material.dart';

import '../m_colors.dart';
import '../util/log.dart';

enum SelectType {
  search,
  custom,
}

class Select<T> extends StatefulWidget {
  final Function(String) onItemSelected;
  final List<T> options;
  final double width;
  final SelectType type;
  final Function(String)? onSearch;
  final String? defaultValue;

  const Select({
    Key? key,
    required this.onItemSelected,
    required this.options,
    required this.width,
    required this.type,
    this.onSearch,
    this.defaultValue,
  }) : super(key: key);

  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  OverlayEntry? overlay;
  String? selectValue;

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
      } else {
        // hideOverlay();
        overlay?.remove();
        overlay = null;
      }
    });
  }

  ///
  /// @desc
  _showSelect(BuildContext context) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position
    double x = position.dx;
    // print(x);
    // print(y);

    final size = box.size;
    // print("SIZE of Red: ${size.width}");
    // print("SIZE of Red: ${size.height}");

    overlay = OverlayEntry(builder: (context) {
      return Positioned(
        top: 99 + size.height + 4,
        left: x,
        child: Container(
          width: size.width,
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: widget.options
                  .map((e) => Material(
                        color: Colors.white,
                        child: InkWell(
                          focusColor: Colors.white,
                          hoverColor: const Color(0xFFF3F3F3),
                          onTap: () {
                            overlay?.remove();
                            overlay = null;
                            setState(() {
                              selectValue = '$e';
                            });
                            if (widget.type == SelectType.search) {
                              controller.text = '$e';
                              FocusScope.of(context).unfocus();
                            }
                            widget.onItemSelected(e);
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
    });

    Overlay.of(context)?.insert(overlay!);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (overlay != null) {
          overlay?.remove();
          overlay = null;
        } else {
          _showSelect(context);
        }
      },
      child: _buildSelect(context, widget.type),
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
        return SizedBox(
          width: widget.width,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectValue!),
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
