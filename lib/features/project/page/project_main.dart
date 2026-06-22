import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/animation/shiningText_animation.dart';

import 'package:portfolio/features/project/controller/projectPage_controller.dart';
import 'package:portfolio/features/project/page/widget/cardPage/projectPage_card.dart';
import 'package:portfolio/style/font_style.dart';
import 'package:portfolio/style/icon_style.dart';

class ProjectMain extends StatefulWidget {
  const ProjectMain({super.key});

  @override
  State<ProjectMain> createState() => _ProjectMainState();
}

class _ProjectMainState extends State<ProjectMain> {
  final ProjectpageController projectpageController = ProjectpageController();

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 60,
        children: [
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Fontstyle.sPrimaryFont(
                    isMobile ? 38 : 48,
                    Theme.of(context).colorScheme.onSurface,
                    FontWeight.bold,
                  ),
                  children: [
                    TextSpan(text: "MY CREATIVE "),
                    TextSpan(
                      text: "WORK",
                      style: Fontstyle.sPrimaryFont(
                        isMobile ? 38 : 48,
                        Colors.red,
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ShiningtextAnimation(
                style: Fontstyle.subFont(18, Colors.white, FontWeight.normal),
                text:
                    "Projects that demonstrate my problem-solving approach, technical skills, and passion for building meaningful software",
              ),
            ],
          ),
          FutureBuilder(
            future: projectpageController.fecthProjectData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset(
                      IconStyle.primaryLoading(),
                      options: LottieOptions(enableMergePaths: false),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No projects found'));
              } else {
                return ProductHomeGlowCardAnimation(
                  projectModel: snapshot.data!,
                  isMobile: isMobile,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
