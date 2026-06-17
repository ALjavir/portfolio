import 'package:flutter/material.dart';

class ShiningtextAnimation extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const ShiningtextAnimation({
    super.key,
    required this.text,
    this.style = const TextStyle(
      fontSize: 16.0, // text-base
      fontWeight: FontWeight.w400, // font-regular
    ),
    this.duration = const Duration(seconds: 2), // duration: 2
  });

  @override
  State<ShiningtextAnimation> createState() => _ShiningTextState();
}

class _ShiningTextState extends State<ShiningtextAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(); // repeat: Infinity

    // Animates a scalar multiplier value to shift the gradient smoothly
    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ), // ease: "linear"
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Replicates Tailwind's color stops: #404040, #fff, #404040
    const baseColor = Color(0xff404040);
    const highlightColor = Colors.white;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn, // bg-clip-text & text-transparent effect
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(
                _animation.value - 1.0,
                -0.3,
              ), // 110deg slant simulation
              end: Alignment(_animation.value + 1.0, 0.3),
              colors: const [
                baseColor,
                baseColor,
                highlightColor,
                baseColor,
                baseColor,
              ],
              stops: const [
                0.0,
                0.35, // 35%
                0.50, // 50%
                0.65, // Balances out the 35% on the trailing side
                1.0,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: Text(
        widget.text,
        style: widget.style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
