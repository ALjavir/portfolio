import 'package:flutter/material.dart';

class TechbordercontainerAnimation extends StatelessWidget {
  final Widget child;
  final double dotSize;
  final double dotGap;
  final Color dotColor;
  final Color borderColor;
  final Color cornerBoxColor;
  final double cornerBoxSize;

  const TechbordercontainerAnimation({
    super.key,
    required this.child,
    this.dotSize = 1.0,
    this.dotGap = 16.0,
    this.dotColor = const Color(0xFFE53935),
    this.borderColor = Colors.white24,
    this.cornerBoxColor = const Color(0xFFE53935),
    this.cornerBoxSize = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: ClipRRect(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _MicroDotPainter(
                  dotSize: dotSize,
                  dotGap: dotGap,
                  color: dotColor,
                ),
              ),
            ),
          ),
        ),

        // 2. Main Content Wrapper with Border
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.0),
          ),
          child: child,
        ),

        // 3. Perfect Pixel Corner Squares
        // Top Left
        Positioned(
          top: -cornerBoxSize / 2,
          left: -cornerBoxSize / 2,
          child: _buildCornerSquare(),
        ),
        // Top Right
        Positioned(
          top: -cornerBoxSize / 2,
          right: -cornerBoxSize / 2,
          child: _buildCornerSquare(),
        ),
        // Bottom Left
        Positioned(
          bottom: -cornerBoxSize / 2,
          left: -cornerBoxSize / 2,
          child: _buildCornerSquare(),
        ),
        // Bottom Right
        Positioned(
          bottom: -cornerBoxSize / 2,
          right: -cornerBoxSize / 2,
          child: _buildCornerSquare(),
        ),
      ],
    );
  }

  Widget _buildCornerSquare() {
    return Container(
      width: cornerBoxSize,
      height: cornerBoxSize,
      color: cornerBoxColor,
    );
  }
}

class _MicroDotPainter extends CustomPainter {
  final double dotSize;
  final double dotGap;
  final Color color;

  _MicroDotPainter({
    required this.dotSize,
    required this.dotGap,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (double x = dotGap / 2; x < size.width; x += dotGap) {
      for (double y = dotGap / 2; y < size.height; y += dotGap) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_MicroDotPainter oldDelegate) {
    return oldDelegate.dotSize != dotSize ||
        oldDelegate.dotGap != dotGap ||
        oldDelegate.color != color;
  }
}
