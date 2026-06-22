import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portfolio/features/skill/page/widget/skillGlowingSkewCard.dart';
import 'package:portfolio/features/home/controller/homePage_controller.dart';
import 'package:portfolio/features/skill/controller/skillPage_controller.dart';
import 'package:portfolio/style/color_style.dart';

class SkillpageCard extends StatefulWidget {
  const SkillpageCard({super.key});

  @override
  State<SkillpageCard> createState() => _SkillpageCardState();
}

class _SkillpageCardState extends State<SkillpageCard> {
  final HomepageController homepageController = Get.find<HomepageController>();
  final SkillpageController skillpageController = Get.put(
    SkillpageController(),
  );

  @override
  void initState() {
    skillpageController.getSkillpageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define the breakpoint for desktop vs mobile
    final bool isDesktop = screenWidth >= 880;

    //const double maxExpandedCellHeight = baseCardHeight + 150;

    return Obx(() {
      if (homepageController.isLoading.value) {
        return const SizedBox(
          height: 300,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final data = skillpageController.skillPageList;
      final gradientColor = ColorStyle.gradientColorSkill;

      if (isDesktop) {
        return SizedBox(
          height: 720,

          child: ListView.separated(
            clipBehavior: Clip.none,

            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 0),

            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            separatorBuilder: (context, index) => const SizedBox(width: 60),
            itemBuilder: (context, index) {
              return Center(
                child: Skillglowingskewcard(
                  description: data[index].text,
                  title: data[index].name,
                  tech: data[index].tech,
                  score: data[index].score,
                  gradientFrom: gradientColor[index][0],
                  gradienMiddle: gradientColor[index][1],
                  gradientTo: gradientColor[index][2],
                ),
              );
            },
          ),
        );
      } else {
        // Mobile: Vertical ListView
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 150),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.length,
          separatorBuilder: (context, index) => const SizedBox(height: 240),
          itemBuilder: (context, index) {
            return Center(
              child: Skillglowingskewcard(
                description: data[index].text,
                title: data[index].name,
                tech: data[index].tech,
                score: data[index].score,
                gradientFrom: gradientColor[index][0],
                gradienMiddle: gradientColor[index][1],
                gradientTo: gradientColor[index][2],
              ),
            );
          },
        );
      }
    });
  }
}
