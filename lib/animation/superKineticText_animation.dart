import 'package:flutter/material.dart';

// Kept this class wrapper intact to match your implementation code snippet
class SuperkinetictextAnimation {
  final Widget child;
  const SuperkinetictextAnimation({required this.child});
}

class LayeredWidgetKineticText extends StatelessWidget {
  final List<SuperkinetictextAnimation> lines;

  const LayeredWidgetKineticText({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    // Increased gap allocations to account for the -30 degree transformation stretch
    final lineSpacing = isMobile ? 55.0 : 55.0;
    final centerIndex = (lines.length / 2).floor();
    final baseOffset = isMobile ? 0.0 : 0.0;

    // 1. REVERSE the array iteration so "HI!" is calculated and rendered from the top
    final reversedLines = lines.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: SizedBox(
        // Calculate dynamic height footprint of the absolute stack
        height: lines.length * lineSpacing + 40.0,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: List.generate(reversedLines.length, (index) {
            final lineData = reversedLines[index];

            // Re-map index positions back to preserve the correct staggered X-offsets
            final originalIndex = (lines.length - 1) - index;
            final translateX = (originalIndex - centerIndex) * baseOffset;

            // Compute precise absolute top values instead of letting Column stack them natively
            final absoluteTop = index * lineSpacing;

            final isEven = originalIndex % 2 == 0;
            final skewX = isEven ? 80.0 : -5.0;
            const skewY = -30.0;
            final scaleY = isEven ? 0.66667 : 1.33333;

            final transformMatrix = Matrix4.identity()
              ..translate(translateX, 0.0)
              ..setEntry(
                0,
                1,
                skewX * (3.141592653589793 / 180.0),
              ) // Swapped 80 to 180 for standard Radian conversion
              ..setEntry(1, 0, skewY * (3.141592653589793 / 180.0))
              ..scale(1.0, scaleY, 1.0);

            return Positioned(
              top: absoluteTop,
              left: 0,
              right: 0,
              child: Transform(
                transform: transformMatrix,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [lineData.child],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
