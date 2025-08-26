import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;
  final Alignment? alignment;

  const Button({
    super.key,
    required this.child,
    required this.onTap,
    this.padding,
    this.width,
    this.height,
    this.decoration,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: alignment,
        height: height,
        padding: padding,
        decoration: decoration,
        child: child,
      ),
    );
  }
}
