import 'package:flutter/material.dart';
import 'dart:math' as math;

class SensorCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final List<Color> gradientColors;
  final double progress; // 0.0 to 1.0
  final VoidCallback? onTap;

  const SensorCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.gradientColors,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = gradientColors.last;
    final trackColor = gradientColors.first.withAlpha(25); // ~0.1 opacity

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8), // Very subtle shadow
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          // Circular Progress Indicator with Animation
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutQuart,
              builder: (context, animatedProgress, child) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    // Make the circle take up as much space as possible
                    final size = math.min(constraints.maxWidth, constraints.maxHeight);
                    return SizedBox(
                      width: size,
                      height: size,
                      child: CustomPaint(
                        painter: _GradientCircularProgressPainter(
                          progress: animatedProgress,
                          gradientColors: gradientColors,
                          backgroundColor: trackColor,
                          strokeWidth: 7.0,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                icon, 
                                color: primaryColor, 
                                size: 22, // Slightly smaller icon
                              ),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: value,
                                      style: const TextStyle(
                                        fontSize: 20, // Smaller font for value
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2E3A46),
                                        height: 1.0,
                                      ),
                                    ),
                                    TextSpan(
                                      text: unit,
                                      style: const TextStyle(
                                        fontSize: 12, // Smaller unit
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF5F6D7A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10), // Slightly reduced spacing
          // Label
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF8E9EAB),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
          ),
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final double strokeWidth;

  _GradientCircularProgressPainter({
    required this.progress,
    required this.gradientColors,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    // Draw clean background track (no blur, just solid color)
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bgPaint);

    // Draw foreground arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = 2 * math.pi * progress.clamp(0.0, 1.0);
    
    // Create gradient
    final gradient = SweepGradient(
      colors: gradientColors.length == 1 ? [gradientColors.first, gradientColors.first] : gradientColors,
      transform: const GradientRotation(-math.pi / 2),
    );

    final fgPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Start from top (-90 degrees)
    const startAngle = -math.pi / 2;
    
    // Draw arc
    canvas.drawArc(rect, startAngle, sweepAngle, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradientColors != gradientColors ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
