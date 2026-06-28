import 'package:flutter/material.dart';
import 'package:stem_union/utils/constants/colors.dart';
import 'package:stem_union/utils/helpers/helper_functions.dart';

class BlueprintGrid extends StatelessWidget {
  const BlueprintGrid({
    super.key,
    required this.child,
    this.cellSize = 36.0,
    this.lineWidth = 1.0,
  });

  final Widget child;
  final double cellSize;
  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return CustomPaint(
      size: Size.infinite,
      painter: _BlueprintGridPainter(
        cellSize: cellSize,
        lineColor: isDark ? TColors.secondry : TColors.primary,
        lineWidth: lineWidth,
      ),
      child: child,
    );
  }
}

class _BlueprintGridPainter extends CustomPainter {
  _BlueprintGridPainter({
    required this.cellSize,
    required this.lineColor,
    required this.lineWidth,
  });

  final double cellSize;
  final Color lineColor;
  final double lineWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = lineWidth;

    // Vertical lines
    for (double x = 0; x <= size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BlueprintGridPainter oldDelegate) {
    return oldDelegate.cellSize != cellSize ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.lineWidth != lineWidth;
  }
}
