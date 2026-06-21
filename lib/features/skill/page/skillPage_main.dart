import 'package:flutter/material.dart';
import 'package:portfolio/features/skill/page/widget/skillPage_card.dart';
import 'package:portfolio/features/skill/page/widget/skillPage_header.dart';

class SkillpageMain extends StatefulWidget {
  const SkillpageMain({super.key});

  @override
  State<SkillpageMain> createState() => _SkillpageMainState();
}

class _SkillpageMainState extends State<SkillpageMain> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 50,
      children: [SkillpageHeader(), SkillpageCard()],
    );
  }
}
