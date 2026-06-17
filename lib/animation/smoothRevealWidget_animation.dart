import 'package:flutter/material.dart';

class SmoothrevealwidgetAnimation extends StatefulWidget {
  final Widget child;

  final Duration delay;
  final Duration animationDuration;

  const SmoothrevealwidgetAnimation({
    super.key,
    required this.child,

    this.delay = const Duration(milliseconds: 500), // Time before it starts
    this.animationDuration = const Duration(
      milliseconds: 1000,
    ), // How long the reveal takes
  });

  @override
  State<SmoothrevealwidgetAnimation> createState() => _SmoothRevealTextState();
}

class _SmoothRevealTextState extends State<SmoothrevealwidgetAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // Fade from 0 to 1
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide up from slightly below (Y: 0.3) to its final position (Y: 0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Wait for the delay, then start the animation
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
