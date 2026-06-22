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
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkillpageHeader(isMobile: isMobile),
          ),

          SkillpageCard(isMobile: isMobile),
        ],
      ),
    );
  }
}
