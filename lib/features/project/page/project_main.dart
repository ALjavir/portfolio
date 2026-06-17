import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio/animation/scrambleText_animation.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';
import 'package:portfolio/features/project/controller/projectPage_controller.dart';
import 'package:portfolio/features/project/page/widget/projectPage_card.dart';
import 'package:portfolio/style/color_style.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 60,
      children: [
        SmoothrevealwidgetAnimation(
          delay: Duration(seconds: 1),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: ScrambletextAnimation(
                    text: "// ",

                    style: Fontstyle.subFont(
                      36,
                      ColorStyle.red,
                      FontWeight.w900,
                    ),
                  ),
                ),

                WidgetSpan(
                  child: ScrambletextAnimation(
                    text: "PROJECT",

                    style: Fontstyle.primaryFont(
                      36,

                      Theme.of(context).colorScheme.onSurface,

                      FontWeight.w500,
                    ),
                  ),
                ),

                WidgetSpan(
                  child: ScrambletextAnimation(
                    text: ".",

                    style: Fontstyle.subFont(
                      36,
                      ColorStyle.red,
                      FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
              return ProjectpageCard(projectModel: snapshot.data!);
            }
          },
        ),
      ],
    );
  }
}
