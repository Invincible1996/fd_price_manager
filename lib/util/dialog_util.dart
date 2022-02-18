import 'package:flutter/material.dart';

showCustomDialog(
  context, {
  required String title,
  required String content,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$title'),
        content: Text('$content'),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.square(45),
            ),
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.square(45),
            ),
            child: Text('OK'),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
