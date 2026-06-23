import 'package:flutter/material.dart';
import 'package:portfolio/features/home/page/widget/homeHero_animation.dart';
import 'package:portfolio/features/home/page/widget/homePage_header.dart';
import 'package:portfolio/features/home/page/widget/homePage_skill.dart';

import 'package:portfolio/theme/gWidget/global_widget.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: TopBar(),
      body: HomeheroAnimation(
        child: Column(
          spacing: isMobile ? 80 : 140,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: HomepageHeader(isMobile: isMobile),
            ),
            HomepageSkill(isMobile: isMobile),
            Padding(
              padding: EdgeInsets.only(bottom: isMobile ? 50 : 0),
              child: scrollD(),
            ),
          ],
        ),
      ),
    );
  }
}
