import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Color color;
  final Widget child;

  const CircularButton({this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: 50,
      height: 50,
      child: child,
    );
  }
}
