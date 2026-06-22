import 'package:flutter/material.dart';
import 'package:portfolio/animation/shiningText_animation.dart';
import 'package:portfolio/style/font_style.dart';

class SkillpageHeader extends StatelessWidget {
  const SkillpageHeader({super.key});

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
              48,
              Theme.of(context).colorScheme.onSurface,
              FontWeight.bold,
              context,
            ),
            children: [
              TextSpan(text: "MY TECHNICAL "),
              TextSpan(
                text: "EXPERTISE",
                style: Fontstyle.sPrimaryFont(
                  48,
                  Colors.red,
                  FontWeight.bold,
                  context,
                ),
              ),
            ],
          ),
        ),
        ShiningtextAnimation(
          style: Fontstyle.subFont(
            18,
            Colors.white,
            FontWeight.normal,
            context,
          ),
          text:
              "Technologies and engineering practices I've mastered through building real-world applications",
        ),
      ],
    );
  }
}
