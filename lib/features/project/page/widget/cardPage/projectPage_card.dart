import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio/features/project/page/widget/cardPage/productHomeglowCard_animation.dart';

import 'package:portfolio/features/project/model/project_model.dart';
import 'package:portfolio/features/project/page/widget/projectPageInfo_main.dart';
import 'package:portfolio/style/color_style.dart';

class ProductHomeGlowCardAnimation extends StatefulWidget {
  final bool isMobile;
  final List<ProjectRowModel> projectModel;

  const ProductHomeGlowCardAnimation({
    super.key,
    required this.projectModel,
    required this.isMobile,
  });

  @override
  State<ProductHomeGlowCardAnimation> createState() => _ProjectpageCardState();
}

class _ProjectpageCardState extends State<ProductHomeGlowCardAnimation> {
  @override
  Widget build(BuildContext context) {
    return desktopProject(widget.projectModel);
  }

  Widget desktopProject(List<ProjectRowModel> projects) {
    // final double screenWidth = MediaQuery.of(context).size.width;
    // final bool isMobile = screenWidth < 768;

    return SizedBox(
      height: 600,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        physics: BouncingScrollPhysics(),

        shrinkWrap: true,

        itemCount: projects.length,

        separatorBuilder: (context, index) => SizedBox(width: 40.0, height: 0),

        itemBuilder: (context, index) {
          return Container(
            width: 300,
            child: MyCard(
              projectRowModel: projects[index],
              index: index,
              isMobile: widget.isMobile,
            ),
          );
        },
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final ProjectRowModel projectRowModel;
  final int index;
  final bool isMobile;
  const MyCard({
    super.key,
    required this.projectRowModel,
    required this.index,
    required this.isMobile,
  });

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
          () => ProjectpageinfoMain(
            projectRowModel: widget.projectRowModel,
            isMobile: widget.isMobile,
          ),
        );
      },
      onHover: (value) {
        isHover.value = value;
      },

      child: AnimatedGradientCard(
        glowColor: ColorStyle.gradientColorproduct[widget.index],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),

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

                  fit: BoxFit.fitHeight,
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
      ),
    );
  }
}
