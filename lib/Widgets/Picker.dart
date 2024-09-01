import 'package:flutter/material.dart';
import '../UI/ui.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final List<BoxShadow> boxShadow;

  const CustomContainer({
    required this.child,
    this.borderColor = Palette.secondaryLight,
    this.backgroundColor = Palette.secondaryLight,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.borderRadius = 8.0,
    this.boxShadow = const [
      BoxShadow(
        offset: Offset(0.0, 2.0),
        blurRadius: 4.0,
        color: Color(0x25000000),
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.0,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
