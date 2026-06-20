import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomeheroAnimation extends StatefulWidget {
  final Widget? child;

  const HomeheroAnimation({Key? key, this.child}) : super(key: key);

  @override
  State<HomeheroAnimation> createState() => _DiagonalWaveBackgroundState();
}

class _DiagonalWaveBackgroundState extends State<HomeheroAnimation>
    with SingleTickerProviderStateMixin {
  ui.FragmentProgram? _program;
  late Ticker _ticker;
  double _elapsedTime = 0.0;

  @override
  void initState() {
    super.initState();
    _loadShader();

    // Ticker feeds constant time updates directly into the layout loop
    _ticker = createTicker((elapsed) {
      setState(() {
        // Slow down time increment here to make it calm (0.003 multiplier instead of 0.01)
        _elapsedTime = (elapsed.inMilliseconds / 1000.0) * 0.3;
      });
    });
  }

  Future<void> _loadShader() async {
    try {
      final program = await ui.FragmentProgram.fromAsset(
        'lib/assets/shaders/wave.frag',
      );
      setState(() {
        _program = program;
        _ticker.start();
      });
    } catch (e) {
      debugPrint("Error compiling/loading shader element: $e");
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_program == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white24)),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: ShaderPainter(
              shader: _program!.fragmentShader(),
              time: _elapsedTime,
            ),
          ),
        ),
        if (widget.child != null) Positioned.fill(child: widget.child!),
      ],
    );
  }
}

class ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;

  ShaderPainter({required this.shader, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    // Map data values strictly matching sequential GLSL uniform indexes:
    shader.setFloat(0, size.width); // u_resolution.x
    shader.setFloat(1, size.height); // u_resolution.y
    shader.setFloat(2, time); // u_time
    shader.setFloat(3, 1.2); // u_xScale (Wave frequency)
    shader.setFloat(4, 0.4); // u_yScale (Wave height swing)
    shader.setFloat(5, 0.04); // u_distortion (Chromatic aberration offset)

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}
