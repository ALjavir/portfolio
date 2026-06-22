import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';
import 'package:portfolio/features/project/model/project_model.dart';
import 'package:portfolio/style/color_style.dart';
import 'package:portfolio/style/font_style.dart';

class ProjectpageinfoHeader extends StatefulWidget {
  final ProjectRowModel projectRowModel;
  const ProjectpageinfoHeader({super.key, required this.projectRowModel});

  @override
  State<ProjectpageinfoHeader> createState() => _ProjectpageinfoHeaderState();
}

class _ProjectpageinfoHeaderState extends State<ProjectpageinfoHeader> {
  final ScrollController _miniController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        SmoothrevealwidgetAnimation(
          delay: const Duration(milliseconds: 500),
          child: Text(
            widget.projectRowModel.name,
            style: Fontstyle.primaryFont(
              42,

              Theme.of(context).colorScheme.onSurface,

              FontWeight.bold,
              context,
            ),
          ),
        ),
        SmoothrevealwidgetAnimation(
          delay: const Duration(milliseconds: 1500),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "// ",
                  style: Fontstyle.subFont(
                    18,
                    Colors.red,
                    FontWeight.w900,
                    context,
                  ),
                ),
                TextSpan(
                  text: widget.projectRowModel.subName,
                  style: Fontstyle.subFont(
                    16,

                    Theme.of(context).colorScheme.onSurface.withAlpha(180),

                    FontWeight.normal,
                    context,
                  ),
                ),
                TextSpan(
                  text: ".",
                  style: Fontstyle.subFont(
                    18,
                    Colors.red,
                    FontWeight.w900,
                    context,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 80),
        SmoothrevealwidgetAnimation(
          delay: const Duration(milliseconds: 2000),
          child: Text(
            widget.projectRowModel.description,
            style: Fontstyle.subFont(
              18,

              Theme.of(context).colorScheme.onSurface.withAlpha(150),

              FontWeight.normal,
              context,
            ),
          ),
        ),
        SizedBox(height: 80),
        Center(
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: SmoothrevealwidgetAnimation(
                  delay: const Duration(milliseconds: 2500),
                  child: Scrollbar(
                    controller: _miniController,
                    thumbVisibility: true,
                    //trackVisibility: true,
                    interactive: true,
                    thickness: 2,
                    child: ListView.builder(
                      controller: _miniController,
                      scrollDirection: Axis.horizontal,

                      shrinkWrap: true,

                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.projectRowModel.tech.length,
                      itemBuilder: (context, index) {
                        final skill = widget.projectRowModel.tech.entries
                            .toList();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.network(
                                skill[index].value,
                                width: 38,
                                height: 38,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                skill[index].key.replaceAll(" ", "\n"),
                                textAlign: TextAlign.center,
                                style: Fontstyle.subFont(
                                  14,
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withAlpha(200),
                                  FontWeight.normal,
                                  context,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SmoothrevealwidgetAnimation(
                delay: const Duration(milliseconds: 3000),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "</ ",
                        style: Fontstyle.subFont(
                          20,
                          Colors.red,
                          FontWeight.w900,
                          context,
                        ),
                      ),
                      TextSpan(
                        text: "POWERED BY",
                        style: Fontstyle.navBarFont(
                          20,
                          Theme.of(context).colorScheme.onSurface,
                          FontWeight.w500,
                          context,
                        ),
                      ),
                      TextSpan(
                        text: " >",
                        style: Fontstyle.subFont(
                          20,
                          Colors.red,
                          FontWeight.w900,
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _miniController.dispose();
    super.dispose();
  }
}
