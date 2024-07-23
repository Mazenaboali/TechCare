import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:tech_care/presentation/Components/dash-border-painter.dart';

class DashedBorderButton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final Widget child;
  final VoidCallback onPressed;

  const DashedBorderButton({
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.borderColor,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: CustomPaint(
          size: Size(width, height),
          painter: DashedBorderPainter(
            borderRadius: borderRadius,
            borderColor: borderColor,
          ),
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );

  }
}