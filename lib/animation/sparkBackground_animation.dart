import 'dart:math';
import 'package:flutter/material.dart';

class SparkbackgroundAnimation extends StatefulWidget {
  final int amount;
  final double speed;
  final int lifetime;
  final Offset direction;
  final Size size;
  final double maxOpacity;
  final Color color;
  final bool randColor;
  final List<double> acceleration;

  const SparkbackgroundAnimation({
    super.key,
    this.amount = 5000,
    this.speed = 0.05,
    this.lifetime = 200,
    this.direction = const Offset(-0.5, 1.0),
    this.size = const Size(2, 2),
    this.maxOpacity = 1.0,
    this.color = const Color.fromRGBO(150, 150, 150, 1.0),
    this.randColor = true,
    this.acceleration = const [5.0, 40.0],
  });

  @override
  State<SparkbackgroundAnimation> createState() => _SparkEffectState();
}

class _Spark {
  double x;
  double y;
  int age;
  double acceleration;
  Color color;
  double opacity;

  _Spark({
    required this.x,
    required this.y,
    required this.acceleration,
    required this.color,
    required this.opacity,
  }) : age = 0;
}

class _SparkEffectState extends State<SparkbackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _ticker;
  final List<_Spark> _sparks = [];
  final Random _random = Random();
  Size _canvasSize = Size.zero;

  // Variables to hold values that might change based on screen width
  late double _currentSpeed;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    // This acts as window.requestAnimationFrame(draw) [cite: 13, 15]
    _ticker =
        AnimationController(
            vsync: this,
            duration: const Duration(days: 365), // Run indefinitely
          )
          ..addListener(_gameLoop)
          ..forward();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  double _randDouble(double min, double max) {
    return _random.nextDouble() * (max - min) + min;
  }

  int _randInt(int min, int max) {
    return _random.nextInt(max - min + 1) + min;
  }

  void _addSpark() {
    // Matches: let x = rand(-200, window.innerWidth + 200); [cite: 7]
    double x = _randDouble(-200, _canvasSize.width + 200);
    // Matches: let y = rand(-200, window.innerHeight + 200); [cite: 8]
    double y = _randDouble(-200, _canvasSize.height + 200);

    // Matches: rand(OPT.acceleration[0], OPT.acceleration[1]) [cite: 4]
    double acc = _randDouble(widget.acceleration[0], widget.acceleration[1]);

    Color sparkColor;
    if (widget.randColor) {
      // Matches: `${rand(0, 255)},${rand(0, 255)},${rand(0, 255)}` [cite: 4]
      sparkColor = Color.fromRGBO(
        _randInt(0, 255),
        _randInt(0, 255),
        _randInt(0, 255),
        1.0,
      );
    } else {
      sparkColor = _currentColor;
    }

    _sparks.add(
      _Spark(
        x: x,
        y: y,
        acceleration: acc,
        color: sparkColor,
        opacity: widget.maxOpacity,
      ),
    );
  }

  void _gameLoop() {
    if (_canvasSize == Size.zero) return;

    // Matches the setInterval logic: adding sparks until we reach OPT.amount
    // Because Flutter runs at 60fps (16.6ms per frame), we add a batch per frame to keep up
    if (_sparks.length < widget.amount) {
      int framesPerSecond = 60;
      int sparksPerFrame = (widget.amount / framesPerSecond).ceil();
      int sparksToAdd = min(sparksPerFrame, widget.amount - _sparks.length);

      for (int i = 0; i < sparksToAdd; i++) {
        _addSpark();
      }
    }

    // Matches the update and remove logic in draw() [cite: 12]
    for (int i = _sparks.length - 1; i >= 0; i--) {
      var spark = _sparks[i];

      if (spark.opacity <= 0) {
        // Matches: array.splice(i, 1); [cite: 12]
        _sparks.removeAt(i);
      } else {
        // Matches: spark.go(); [cite: 10]
        spark.x +=
            _currentSpeed *
            widget.direction.dx *
            spark.acceleration /
            2; // [cite: 5]
        spark.y +=
            _currentSpeed *
            widget.direction.dy *
            spark.acceleration /
            2; // [cite: 6]
        spark.age++;
        // Matches: this.opacity = OPT.maxopacity - ++this.age / OPT.lifetime; [cite: 6]
        spark.opacity = widget.maxOpacity - (spark.age / widget.lifetime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _canvasSize = Size(constraints.maxWidth, constraints.maxHeight);

        // Matches: speed: window.innerWidth < 520 ? 0.05 : speed
        _currentSpeed = constraints.maxWidth < 520 ? 0.05 : widget.speed;

        // Matches: color: window.innerWidth < 520 ? '150, 150, 150' : color
        _currentColor = constraints.maxWidth < 520
            ? const Color.fromRGBO(150, 150, 150, 1.0)
            : widget.color;

        return IgnorePointer(
          // Matches: pointerEvents: 'none' [cite: 17]
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors
                .transparent, // Matches: background: 'transparent' [cite: 17]
            child: CustomPaint(
              painter: _SparkPainter(
                sparks: _sparks,
                sparkSize: widget.size,
                repaint: _ticker, // Automatically triggers repaint on tick
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SparkPainter extends CustomPainter {
  final List<_Spark> sparks;
  final Size sparkSize;

  _SparkPainter({
    required this.sparks,
    required this.sparkSize,
    required Listenable repaint,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    // Flutter's CustomPainter automatically clears the canvas every frame,
    // so we don't need ctx.clearRect like in React. [cite: 11]

    final paint = Paint();

    for (var spark in sparks) {
      if (spark.opacity > 0) {
        // Matches: ctx.fillStyle = `rgba(${spark.color}, ${spark.opacity})`; [cite: 10]
        paint.color = spark.color.withOpacity(spark.opacity.clamp(0.0, 1.0));

        // Matches: ctx.rect(x, y, OPT.size[0], OPT.size[1]...); [cite: 10]
        canvas.drawRect(
          Rect.fromLTWH(spark.x, spark.y, sparkSize.width, sparkSize.height),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) => true;
}
