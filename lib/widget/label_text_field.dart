///
/// @date: 2022/2/14 14:16
/// @author: kevin
/// @description: dart
import 'package:flutter/material.dart';

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
    return Container(
      width: 200,
      child: Row(
        children: [
          Text('$label:'),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              onChanged: onChange,
              decoration: InputDecoration(
                hintText: placeholderText,
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.all(10),
                isDense: true,
                border: OutlineInputBorder(
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
