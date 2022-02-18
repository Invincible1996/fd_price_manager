///
/// @date: 2022/2/18 10:44
/// @author: kevin
/// @description: dart
///
import 'package:flutter/material.dart';

class CustomPopupRoute extends PopupRoute {
  Widget child;

  CustomPopupRoute({required this.child});

  final Duration _duration = Duration(milliseconds: 100);

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

///
/// @param context
/// @param child
/// @description: 弹出自定义对话框
///
showCustomDialog(BuildContext context, Widget child) {
  Navigator.push(context, CustomPopupRoute(child: child));
}
