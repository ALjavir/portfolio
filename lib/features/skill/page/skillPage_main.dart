import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portfolio/animation/ani.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';
import 'package:portfolio/features/home/controller/homePage_controller.dart';

class SkillpageMain extends StatefulWidget {
  const SkillpageMain({super.key});

  @override
  State<SkillpageMain> createState() => _SkillMainState();
}

class _SkillMainState extends State<SkillpageMain> {
  final HomepageController homepageController = Get.find<HomepageController>();

  @override
  Widget build(BuildContext context) {
    print(homepageController.showList.length);
    return Scaffold(
      body:
          // SUCCESS
          SmoothrevealwidgetAnimation(
            delay: Duration(seconds: 3),
            child: Obx(() {
              if (homepageController.isLoading.value) {
                return CircularProgressIndicator();
              }
              final items = homepageController.showList
                  .map((s) => BentoItemData(title: s.name, description: s.text))
                  .toList();
              return SimpleBentoGrid(items: items);
            }),
          ),
    );
  }
}
