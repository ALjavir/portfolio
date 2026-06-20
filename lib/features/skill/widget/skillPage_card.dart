import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portfolio/features/skill/widget/skillGlowingSkewCard.dart';
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
    if (screenWidth >= 1024) {
      crossAxisCount = 4;
    } else if (screenWidth >= 640) {
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

    // final gradientColor = [
    //   // 1. Red → Orange → Yellow
    //   [Color(0xFFFF005C), Color(0xFFFF4D4D), Color(0xFFFFBC00)],

    //   // 2. Pink → Purple → Blue
    //   [Color(0xFFFF1493), Color(0xFFB84DFF), Color(0xFF1DA1FF)],

    //   // 3. Cyan → Teal → Green
    //   [Color(0xFF00D4FF), Color(0xFF00E5C3), Color(0xFF7CFF2B)],

    //   // 4. Purple → Indigo → Cyan
    //   [Color(0xFF8A2BE2), Color(0xFF5B5FFF), Color(0xFF00E5FF)],

    //   // 5. Orange → Pink → Purple
    //   [Color(0xFFFF7A00), Color(0xFFFF4D8D), Color(0xFFB84DFF)],

    //   // 6. Green → Aqua → Blue
    //   [Color(0xFF39FF14), Color(0xFF00FFA3), Color(0xFF00D4FF)],

    //   // 7. Gold → Orange → Red
    //   [Color(0xFFFFD700), Color(0xFFFF8C00), Color(0xFFFF3D3D)],

    //   // 8. Sky Blue → Royal Blue → Purple
    //   [Color(0xFF00C6FF), Color(0xFF0072FF), Color(0xFF8E2DE2)],

    //   // 9. Mint → Emerald → Lime
    //   [Color(0xFF00FFB3), Color(0xFF00C853), Color(0xFFAEEA00)],

    //   // 10. Magenta → Violet → Electric Blue
    //   [Color(0xFFFF00FF), Color(0xFF7F00FF), Color(0xFF00BFFF)],
    // ];

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
            padding: EdgeInsets.only(bottom: 100),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skillpageController.skillPageList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: crossAxisCount * 40,
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
