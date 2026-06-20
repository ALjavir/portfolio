import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/features/skill/widget/skillGlowingSkewCard.dart';
import 'package:portfolio/features/project/page/widget/productHomeglowCard_animation.dart';

import 'package:portfolio/features/project/model/project_model.dart';
import 'package:portfolio/features/project/page/widget/projectPageInfo_main.dart';
import 'package:portfolio/style/color_style.dart';
import 'package:portfolio/style/font_style.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductHomeGlowCardAnimation extends StatefulWidget {
  final List<ProjectRowModel> projectModel;

  const ProductHomeGlowCardAnimation({super.key, required this.projectModel});

  @override
  State<ProductHomeGlowCardAnimation> createState() => _ProjectpageCardState();
}

class _ProjectpageCardState extends State<ProductHomeGlowCardAnimation> {
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  @override
  Widget build(BuildContext context) {
    return isMobile(context)
        ? mobileProject(widget.projectModel)
        : desktopProject(widget.projectModel);
  }

  Widget desktopProject(List<ProjectRowModel> projects) {
    return MasonryGridView.count(
      crossAxisCount: 3,

      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      mainAxisSpacing: 30,
      crossAxisSpacing: 30,

      itemCount: projects.length,

      itemBuilder: (context, index) =>
          MyCard(projectRowModel: projects[index], index: index),
    );
  }

  Widget mobileProject(List<ProjectRowModel> projects) {
    return ListView.separated(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      itemCount: projects.length,

      separatorBuilder: (_, _) => const SizedBox(height: 30),

      itemBuilder: (context, index) =>
          MyCard(projectRowModel: projects[index], index: index),
    );
  }
}

class MyCard extends StatefulWidget {
  final ProjectRowModel projectRowModel;
  final int index;
  const MyCard({super.key, required this.projectRowModel, required this.index});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  RxBool isHover = false.obs;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        Get.to(
          () => ProjectpageinfoMain(projectRowModel: widget.projectRowModel),
        );
      },
      onHover: (value) {
        isHover.value = value;
      },

      child: AnimatedGradientCard(
        glowColor: ColorStyle.gradientColorproduct[widget.index],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // IMAGE
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),

              child: isMobile(context)
                  ? CachedNetworkImage(
                      imageUrl: widget.projectRowModel.thumbImage,
                      placeholder: (_, _) => Padding(
                        padding: const EdgeInsets.all(80),
                        child: Center(
                          child: Icon(Icons.image_search_rounded, size: 80),
                        ),
                      ),

                      errorWidget: (_, _, _) => Padding(
                        padding: EdgeInsets.all(80),
                        child: Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            color: Colors.red,
                            size: 80,
                          ),
                        ),
                      ),

                      fit: BoxFit.cover,
                    )
                  : Obx(
                      () => AnimatedScale(
                        scale: isMobile(context)
                            ? 1
                            : isHover.value
                            ? 1.08
                            : 1,

                        duration: const Duration(milliseconds: 400),

                        curve: Curves.easeOut,

                        child: CachedNetworkImage(
                          imageUrl: widget.projectRowModel.thumbImage,
                          placeholder: (_, _) => Padding(
                            padding: const EdgeInsets.all(80),
                            child: Center(
                              child: Icon(Icons.image_search_rounded, size: 80),
                            ),
                          ),

                          errorWidget: (_, _, _) => Padding(
                            padding: EdgeInsets.all(80),
                            child: Center(
                              child: Icon(
                                Icons.broken_image_rounded,
                                color: Colors.red,
                                size: 80,
                              ),
                            ),
                          ),

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // TITLE
                  Text(
                    widget.projectRowModel.name,

                    style: Fontstyle.primaryFont(
                      28,

                      Theme.of(context).colorScheme.onSurface,

                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // SUBTITLE
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "// ",
                          style: Fontstyle.subFont(
                            16,
                            ColorStyle.red,
                            FontWeight.w900,
                          ),
                        ),
                        TextSpan(
                          text: widget.projectRowModel.subName,
                          style: Fontstyle.subFont(
                            16,

                            Theme.of(
                              context,
                            ).colorScheme.onSurface.withAlpha(180),

                            FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: ".",
                          style: Fontstyle.subFont(
                            16,
                            ColorStyle.red,
                            FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
