import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const Button({
    super.key,
    required this.child,
    required this.onTap,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        child: child,
      ),
    );
  }
}
