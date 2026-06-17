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
    this.dotSize = 1.0, // Tiny micro-dots matching your image
    this.dotGap = 16.0, // Spread out gap distance
    this.dotColor = const Color(0xFFE53935), // Red dots matching image_90f6e3
    this.borderColor = Colors.white24, // Thin subtle border
    this.cornerBoxColor = const Color(0xFFE53935), // Red corner anchor squares
    this.cornerBoxSize = 15.0, // Size of the corner anchor boxes
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip
          .none, // Allows corner anchors to sit perfectly on the outer edges
      children: [
        // 1. The Background Dot Canvas (Clipped to stay inside the border)
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

    // Grid painting loops restricted safely inside container size bounds
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
