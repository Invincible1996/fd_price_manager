///
/// @date: 2022/2/14 14:16
/// @author: kevin
/// @description: dart
import 'package:flutter/material.dart';

import '../m_colors.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final String placeholderText;
  final Function(String) onChange;

  const LabelTextField({
    Key? key,
    required this.label,
    required this.onChange,
    required this.placeholderText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          Text('$label:'),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChange,
              decoration: InputDecoration(
                hintText: placeholderText,
                hintStyle: const TextStyle(fontSize: 14),
                contentPadding: const EdgeInsets.all(10),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MColors.primaryColor,
                    width: 1.0,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                    width: 1,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
