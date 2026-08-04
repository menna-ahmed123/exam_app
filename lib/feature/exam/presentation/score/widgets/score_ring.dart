import 'dart:math' as math;

import 'package:exam_app/core/resources/app_palette.dart';
import 'package:exam_app/core/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class ScoreRing extends StatelessWidget {
  const ScoreRing({super.key, required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final clamped = percentage.clamp(0, 100).toDouble();
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: _ScoreRingPainter(percentage: clamped),
        child: Center(
          child: Text(
            '${clamped.round()}%',
            style: AppTextStyles.styleMedium20(),
          ),
        ),
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  _ScoreRingPainter({required this.percentage});

  final double percentage;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const strokeWidth = 12.0;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth);

    final backgroundPaint = Paint()
      ..color = AppPalette.optionBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final correctPaint = Paint()
      ..color = AppPalette.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final wrongPaint = Paint()
      ..color = AppPalette.error
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, 0, 2 * math.pi, false, backgroundPaint);

    final correctSweep = (percentage / 100) * 2 * math.pi;
    final wrongSweep = ((100 - percentage) / 100) * 2 * math.pi;
    const start = -math.pi / 2;

    canvas.drawArc(rect, start, correctSweep, false, correctPaint);
    if (wrongSweep > 0) {
      canvas.drawArc(
        rect,
        start + correctSweep,
        wrongSweep,
        false,
        wrongPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}
