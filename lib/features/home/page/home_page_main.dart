import 'package:flutter/material.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';
import 'package:portfolio/animation/sparkBackground_animation.dart';
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
      // appBar: TopBar(),
      body: Stack(
        children: [
          const SparkbackgroundAnimation(
            // You can customize the look here:
            amount: 500,
            speed: 0.01,
            randColor: false, // Set to false if you want uniform colors
          ),
          Center(
            child: Column(
              spacing: 100,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomepageHeader(),
                HomepageSkill(),
                SmoothrevealwidgetAnimation(
                  delay: Duration(seconds: 5),
                  child: scrollD(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
