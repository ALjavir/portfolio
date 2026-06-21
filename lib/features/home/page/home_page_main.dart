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
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: TopBar(),
      body: HomeheroAnimation(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 100,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [HomepageHeader(), HomepageSkill(), scrollD()],
          ),
        ),
      ),
    );
  }
}
