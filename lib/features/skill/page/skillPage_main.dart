import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:portfolio/animation/ani.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';
import 'package:portfolio/features/home/controller/homePage_controller.dart';
import 'package:portfolio/style/icon_style.dart';
import 'package:portfolio/theme/gWidget/global_widget.dart';

class SkillpageMain extends StatefulWidget {
  const SkillpageMain({super.key});

  @override
  State<SkillpageMain> createState() => _SkillMainState();
}

class _SkillMainState extends State<SkillpageMain> {
  final HomepageController homepageController = Get.find<HomepageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: homepageController.logoData,

        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: lottieImage(IconStyle.primaryLoading(), 180));
          }

          // ERROR
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(child: lottieImage(IconStyle.error(), 180));
          }

          final skills = snapshot.data!;

          // SUCCESS
          return SmoothrevealwidgetAnimation(
            delay: Duration(seconds: 3),
            child: SimpleBentoGrid(
              items: skills
                  .map((s) => BentoItemData(title: s.name, description: s.text))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
