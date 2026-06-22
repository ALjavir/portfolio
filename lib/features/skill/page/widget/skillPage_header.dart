import 'package:flutter/material.dart';
import 'package:portfolio/animation/shiningText_animation.dart';
import 'package:portfolio/style/font_style.dart';

class SkillpageHeader extends StatelessWidget {
  final bool isMobile;
  const SkillpageHeader({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Fontstyle.sPrimaryFont(
              isMobile ? 38 : 48,
              Theme.of(context).colorScheme.onSurface,
              FontWeight.bold,
            ),
            children: [
              TextSpan(text: "MY TECHNICAL "),
              TextSpan(
                text: "EXPERTISE",
                style: Fontstyle.sPrimaryFont(
                  isMobile ? 38 : 48,
                  Colors.red,
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ShiningtextAnimation(
          style: Fontstyle.subFont(18, Colors.white, FontWeight.normal),
          text:
              "Technologies and engineering practices I've mastered through building real-world applications",
        ),
      ],
    );
  }
}
