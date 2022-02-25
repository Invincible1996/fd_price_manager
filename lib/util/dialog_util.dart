import 'package:fd_price_manager/util/log.dart';
import 'package:flutter/material.dart';

import '../widget/custom_dialog.dart';

///
///
///
///
showSelect(BuildContext context) {
  RenderBox box = context.findRenderObject() as RenderBox;
  Offset position = box.localToGlobal(Offset.zero); //this is global position
  double x = position.dx;
  double y = position.dy;
  print(x);
  print(y);
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
            bottom: 45,
            right: 0,
            child: Container(
              width: size.width,
              height: 200,
              color: Colors.red,
            ),
          )
          // _buildMenu(context, x, y, size),
        ],
      ),
    ),
  );
}

///
///
///
showConfirmDialog(
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
            child: Text('取消'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.square(45),
            ),
            child: Text('确认'),
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
