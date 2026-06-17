import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:portfolio/features/project/model/project_model.dart';
import 'package:portfolio/features/project/page/widget/projectPageInfo_image.dart';
import 'package:portfolio/features/project/page/widget/projectPageInfo_header.dart';
import 'package:portfolio/features/project/page/widget/projectPageInfo_video.dart';
import 'package:portfolio/style/font_style.dart';

class ProjectpageinfoMain extends StatefulWidget {
  final ProjectRowModel projectRowModel;
  const ProjectpageinfoMain({super.key, required this.projectRowModel});

  @override
  State<ProjectpageinfoMain> createState() => _ProjectpageinfoMainState();
}

class _ProjectpageinfoMainState extends State<ProjectpageinfoMain> {
  RxBool isHover = false.obs;
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),

              onPressed: () {
                Navigator.pop(context);
              },
              onHover: (value) {
                isHover.value = value;
              },
            ),

            Obx(
              () => Text(
                "Back",

                style: Fontstyle.navBarFont(
                  18,

                  isHover.value
                      ? Theme.of(context).colorScheme.onSurface
                      : Colors.transparent,

                  FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),

        child: Column(
          spacing: 80,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            if (isMobile(context)) ...[
              ProjectpageinfoHeader(projectRowModel: widget.projectRowModel),

              ProjectpageinfoVideo(videoLink: widget.projectRowModel.video),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ProjectpageinfoHeader(
                      projectRowModel: widget.projectRowModel,
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: ProjectpageinfoVideo(
                      videoLink: widget.projectRowModel.video,
                    ),
                  ),
                ],
              ),
            ],

            ProjectpageinfoImage(page: widget.projectRowModel.pageImage),
          ],
        ),

        //
      ),
    );
  }
}
