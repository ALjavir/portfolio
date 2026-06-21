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

    int crossAxisCount = 1;
    if (screenWidth >= 1080) {
      crossAxisCount = 4;
    } else if (screenWidth >= 880) {
      crossAxisCount = 2;
    }

    const double horizontalPadding = 40.0;
    const double crossAxisSpacing = 40.0;
    final double usableWidth =
        screenWidth -
        horizontalPadding -
        (crossAxisSpacing * (crossAxisCount - 1));
    final double cellWidth = usableWidth / crossAxisCount;
    const double baseCardHeight = 300.0;

    final double maxExpandedCellHeight = baseCardHeight + 150;
    final double dynamicAspectRatio = cellWidth / maxExpandedCellHeight;

    return Obx(() {
      if (homepageController.isLoading.value)
        return SizedBox(
          height: 300,
          child: Center(child: CircularProgressIndicator()),
        );
      else
        return
        // This remains non-positioned so the Stack knows exactly how tall it needs to grow.
        Center(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skillpageController.skillPageList.length,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: crossAxisCount * 80,
              childAspectRatio: dynamicAspectRatio,
            ),
            itemBuilder: (context, index) {
              final data = skillpageController.skillPageList;
              final gradientColor = ColorStyle.gradientColorSkill;
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
    });
  }
}
