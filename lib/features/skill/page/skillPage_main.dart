import 'package:flutter/material.dart';
import 'package:portfolio/animation/sparkBackground_animation.dart';
import 'package:portfolio/features/skill/widget/skillPage_card.dart';
import 'package:portfolio/features/skill/widget/skillPage_header.dart';

class SkillpageMain extends StatefulWidget {
  const SkillpageMain({super.key});

  @override
  State<SkillpageMain> createState() => _SkillpageMainState();
}

class _SkillpageMainState extends State<SkillpageMain> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: SparkbackgroundAnimation(
            amount: 500,
            speed: 0.01,
            randColor: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [SkillpageHeader(), SkillpageCard()],
          ),
        ),
      ],
    );
  }
}
