import 'dart:math';

import 'package:flutter/material.dart';

class ScrambletextAnimation extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ScrambletextAnimation({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  State<ScrambletextAnimation> createState() => _ScrambleTextState();
}

class _ScrambleTextState extends State<ScrambletextAnimation> {
  String displayedText = "";
  final random = Random();
  final chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() async {
    for (int i = 0; i <= widget.text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));

      String scrambled = widget.text.split('').asMap().entries.map((entry) {
        if (entry.key < i) {
          return widget.text[entry.key];
        } else {
          return chars[random.nextInt(chars.length)];
        }
      }).join();

      if (mounted) {
        setState(() {
          displayedText = scrambled;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(displayedText, style: widget.style);
  }
}
