// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/style/font_style.dart';

class Skillglowingskewcard extends StatefulWidget {
  final String title;
  final String description;
  final List tech;
  final double score;
  final Color gradientFrom;
  final Color gradienMiddle;
  final Color gradientTo;
  final bool isMobile;

  const Skillglowingskewcard({
    super.key,
    required this.title,
    required this.description,
    required this.gradientFrom,
    required this.gradientTo,
    required this.tech,
    required this.score,
    required this.gradienMiddle,
    required this.isMobile,
  });

  @override
  State<Skillglowingskewcard> createState() => _GlowingSkewCardState();
}

class _GlowingSkewCardState extends State<Skillglowingskewcard>
    with TickerProviderStateMixin {
  late AnimationController _hoverController;
  late AnimationController _floatController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    // 500ms transition matching duration-500
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Infinite loop for the floating blob effect
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
      if (_isHovered) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = widget.isMobile ? 320 : 400.0;
    const double cardHeight = 350.0;
    const double skewAngleAtRest = 18.0 * math.pi / 180.0;

    return InkWell(
      onTap: () {
        setState(() {
          _handleHover(!_isHovered);
        });
      },

      // onHover: (value) {
      //   setState(() {
      //     _handleHover(!_isHovered);
      //   });
      // },
      child: AnimatedBuilder(
        animation: Listenable.merge([_hoverController, _floatController]),
        builder: (context, child) {
          final double hoverVal = _hoverController.value;
          final double floatVal = _floatController.value;

          // Interpolations for Skewed Panels
          final double panelLeft = lerpDouble(78.0, 46.0, hoverVal)!;
          final double panelWidth = lerpDouble(
            cardWidth * 0.5,
            cardWidth - 90.0,
            hoverVal,
          )!;
          final double currentSkew = lerpDouble(
            skewAngleAtRest,
            0.0,
            hoverVal,
          )!;

          // FIX 1: Smoothly animate the card height instead of an instant snap back
          final double currentCardHeight = lerpDouble(
            cardHeight,
            cardHeight,
            hoverVal,
          )!;

          // Interpolations for Content Shifting & Padding
          final double contentBottom = lerpDouble(0.0, -150.0, hoverVal)!;
          final double contentPaddingTopBottom = lerpDouble(
            20.0,
            40.0,
            hoverVal,
          )!; // Adjusted max slightly for safe layout space

          // Organic mathematical calculations for infinite blob floating paths
          final double floatX1 =
              math.sin(floatVal * 2 * math.pi) * -10 * hoverVal;
          final double floatY1 =
              math.cos(floatVal * 2 * math.pi) * 10 * hoverVal;
          final double floatX2 =
              math.sin((floatVal * 2 * math.pi) + math.pi) * -10 * hoverVal;
          final double floatY2 =
              math.cos((floatVal * 2 * math.pi) + math.pi) * 10 * hoverVal;

          // Blob 1 (Top Left) Positioning
          final double blob1Size = lerpDouble(0.0, 100.0, hoverVal)!;
          final double blob1Top = lerpDouble(0.0, -50.0, hoverVal)! + floatY1;
          final double blob1Left = lerpDouble(50.0, 60.0, hoverVal)! + floatX1;

          // Blob 2 (Bottom Right) Positioning
          final double blob2Size = lerpDouble(0.0, 100.0, hoverVal)!;
          final double blob2Bottom =
              lerpDouble(0.0, -200.0, hoverVal)! + floatY2;
          final double blob2Right = lerpDouble(0.0, 60.0, hoverVal)! + floatX2;

          return SizedBox(
            width: cardWidth,
            // Match the outer boundary to the current animated height
            height: currentCardHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Glowing Aura Layer
                Positioned(
                  top: 0,
                  left: panelLeft,
                  width: panelWidth,
                  height: currentCardHeight + 150,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Transform(
                      transform: Matrix4.skewX(currentSkew),
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                            colors: [
                              widget.gradientFrom,
                              widget.gradienMiddle,
                              widget.gradientTo,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // 2. Crisp Skewed Gradient Panel Layer
                Positioned(
                  top: 0,
                  left: panelLeft,
                  width: panelWidth,
                  height: currentCardHeight + 150,
                  child: Transform(
                    transform: Matrix4.skewX(currentSkew),
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [widget.gradientFrom, widget.gradientTo],
                        ),
                      ),
                    ),
                  ),
                ),

                // 3. Animated Blob 1 (Top-Left)
                if (hoverVal > 0.01)
                  Positioned(
                    top: blob1Top,
                    left: blob1Left,
                    width: blob1Size,
                    height: blob1Size,
                    child: Opacity(opacity: hoverVal, child: const GlassBlob()),
                  ),

                // 4. Animated Blob 2 (Bottom-Right)
                if (hoverVal > 0.01)
                  Positioned(
                    bottom: blob2Bottom,
                    right: blob2Right,
                    width: blob2Size,
                    height: blob2Size,
                    child: Opacity(opacity: hoverVal, child: const GlassBlob()),
                  ),

                // 5. Glassmorphic Content Card Layer
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  //top: 0,
                  curve: Curves.easeIn,

                  bottom: contentBottom,
                  width: cardWidth,
                  height: _isHovered
                      ? currentCardHeight + 150
                      : currentCardHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Stack(
                        alignment: AlignmentGeometry.topRight,
                        children: [
                          Container(
                            // Ensure the container fills the animated height bounds smoothly
                            width: double.infinity,
                            height: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: contentPaddingTopBottom,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.title,
                                  style: Fontstyle.primaryFont(
                                    28,
                                    Colors.white,
                                    FontWeight.normal,
                                  ),
                                ),
                                Wrap(
                                  spacing: 6.0,
                                  runSpacing: 6.0,
                                  children: widget.tech.map((skill) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        skill,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Flexible(
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    style: Fontstyle.subFont(
                                      18,
                                      Colors.white70,
                                      FontWeight.normal,
                                    ),
                                    child: Text(
                                      widget.description,
                                      maxLines: _isHovered ? 100 : 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                                //const SizedBox(height: 8),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    widget.score.toString(),
                                    style: Fontstyle.subFont(
                                      20,
                                      Colors.white,
                                      FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    " / 10",
                                    style: Fontstyle.subFont(
                                      18,
                                      Colors.white30,
                                      FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: AlignmentGeometry.bottomLeft,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                // FIX 1: Increased default height to 30 so a 14pt text fits perfectly
                                height: _isHovered ? 0 : 30,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: _isHovered ? 0.0 : 1.0,
                                  child: Text(
                                    "See More →",
                                    style: Fontstyle.subFont(
                                      18,
                                      Colors.white,
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Simplified lerp helper to avoid importing dart:ui explicitly everywhere
  double? lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

class GlassBlob extends StatelessWidget {
  const GlassBlob({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 5),
                blurRadius: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
