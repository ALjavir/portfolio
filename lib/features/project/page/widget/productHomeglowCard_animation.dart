// ignore_for_file: deprecated_member_use

import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedGradientCard extends StatefulWidget {
  final Widget child;
  //final GlowColor glowColor;
  final List<Color> glowColor;

  const AnimatedGradientCard({
    super.key,
    required this.child,
    //this.glowColor = GlowColor.blue,
    required this.glowColor,
  });

  @override
  State<AnimatedGradientCard> createState() => _AnimatedGradientCardState();
}

class _AnimatedGradientCardState extends State<AnimatedGradientCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600), //
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.glowColor;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _ProgressBorderPainter(
              progress: _controller.value,
              colors: colors,
              borderRadius: 16,
              borderWidth: 3,
            ),
            child: child,
          );
        },
        child: Container(
          height: 800,
          padding: const EdgeInsets.all(15),
          child: widget.child,
        ),
      ),
    );
  }
}

class _ProgressBorderPainter extends CustomPainter {
  final double progress;
  final List<Color> colors;
  final double borderRadius;
  final double borderWidth;

  _ProgressBorderPainter({
    required this.progress,
    required this.colors,
    required this.borderRadius,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double r = borderRadius;
    final double inset =
        borderWidth /
        2; // Inset so the border doesn't clip outside the widget bounds
    final double innerR = math.max(0.0, r - inset);

    // 1. Draw the solid dark background of the card
    final bgRect = Offset.zero & size;
    final bgRRect = RRect.fromRectAndRadius(bgRect, Radius.circular(r));
    canvas.drawRRect(bgRRect, Paint()..color = Colors.white.withOpacity(0.05));

    // 2. Define the exact geometric path of the border edges
    // We start exactly at the top-left (after the corner arc) to perfectly map out the length.
    final path = Path()
      ..moveTo(r, inset)
      ..lineTo(w - r, inset) // Top edge
      ..arcToPoint(
        Offset(w - inset, r),
        radius: Radius.circular(innerR),
        clockwise: true,
      )
      ..lineTo(w - inset, h - r) // Right edge
      ..arcToPoint(
        Offset(w - r, h - inset),
        radius: Radius.circular(innerR),
        clockwise: true,
      )
      ..lineTo(r, h - inset) // Bottom edge
      ..arcToPoint(
        Offset(inset, h - r),
        radius: Radius.circular(innerR),
        clockwise: true,
      )
      ..lineTo(inset, r) // Left edge
      ..arcToPoint(
        Offset(r, inset),
        radius: Radius.circular(innerR),
        clockwise: true,
      )
      ..close();

    // Draw a subtle default border track behind the animation
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..color = Colors.white.withOpacity(0.05),
    );

    if (progress == 0.0) return;

    // 3. Extract path metrics to divide the perimeter into 4 animated segments
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final double totalLength = metric.length;

    // Each of the 4 segments will draw exactly 1/4 of the total path at maximum progress
    final double drawLength = (totalLength / 4) * progress;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ).createShader(bgRect);

    // Segment 1: Top-Left pushing Right (towards Top-Right)
    canvas.drawPath(metric.extractPath(0.0, drawLength), paint);

    // Segment 2: Top-Left pushing Down (towards Bottom-Left)
    // We start at the end of the path (totalLength) and draw backwards
    canvas.drawPath(
      metric.extractPath(totalLength - drawLength, totalLength),
      paint,
    );

    // Segment 3: Bottom-Right pushing Left (towards Bottom-Left)
    // The exact midpoint of our path (totalLength / 2) sits perfectly at the Bottom-Right corner
    canvas.drawPath(
      metric.extractPath(totalLength / 2, (totalLength / 2) + drawLength),
      paint,
    );

    // Segment 4: Bottom-Right pushing Up (towards Top-Right)
    canvas.drawPath(
      metric.extractPath((totalLength / 2) - drawLength, totalLength / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.colors != colors;
  }
}
