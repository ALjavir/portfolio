import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:portfolio/features/project/page/widget/cardPage/AnimatedGradientCardBorder_animation.dart';

import 'package:portfolio/features/project/model/project_model.dart';
import 'package:portfolio/features/project/page/widget/projectPageInfo_main.dart';
import 'package:portfolio/style/color_style.dart';
import 'package:portfolio/style/font_style.dart';

class ProductMainCardGlowCard extends StatefulWidget {
  final bool isMobile;
  final List<ProjectRowModel> projectModel;

  const ProductMainCardGlowCard({
    super.key,
    required this.projectModel,
    required this.isMobile,
  });

  @override
  State<ProductMainCardGlowCard> createState() => _ProjectpageCardState();
}

class _ProjectpageCardState extends State<ProductMainCardGlowCard> {
  final RxInt _currentIndex = 0.obs;

  // compute the visual step used to calculate index from scroll offset (card width + horizontal margin)
  double get itemStep => (widget.isMobile ? 300 : 400) + 40;

  @override
  Widget build(BuildContext context) {
    final projects = widget.projectModel;

    return Column(
      spacing: 50,
      children: [
        SizedBox(
          height: widget.isMobile ? 500 : 600,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              int newIndex = (scrollNotification.metrics.pixels / itemStep)
                  .round();
              newIndex = newIndex.clamp(0, projects.length - 1);

              if (newIndex != _currentIndex.value) {
                _currentIndex.value = newIndex;
              }
              return true;
            },
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: projects.length,
              separatorBuilder: (context, index) =>
                  SizedBox(width: 0.0, height: 0),
              itemBuilder: (context, index) {
                return Container(
                  // color: Colors.yellow,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: widget.isMobile ? 300 : 400,
                  child: MyCard(
                    projectRowModel: projects[index],
                    index: index,
                    isMobile: widget.isMobile,
                  ),
                );
              },
            ),
          ),
        ),

        if (widget.isMobile)
          Obx(
            () => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              width: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_currentIndex.value + 1}",
                    style: Fontstyle.sPrimaryFont(
                      20,
                      Colors.white,
                      FontWeight.bold,
                    ),
                  ),
                  Text(
                    " / ${projects.length}",
                    style: Fontstyle.sPrimaryFont(
                      18,
                      Colors.white60,
                      FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
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

  RxBool isTap = false.obs;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // borderRadius: BorderRadius.circular(20),
      onTap: () {
        isTap.value = true;
        Future.delayed(Duration(seconds: 5), () {
          Get.to(
            () => ProjectpageinfoMain(
              projectRowModel: widget.projectRowModel,
              isMobile: widget.isMobile,
            ),
          );
        });
      },
      onHover: (value) {
        isHover.value = value;
      },
      child: Obx(
        () => AnimatedGradientCardBorder(
          isTap: isTap.value,
          glowColor: ColorStyle.gradientColorproduct[widget.index],
          child: Stack(
            alignment: AlignmentGeometry.bottomLeft,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),

                  child: widget.isMobile
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
                            scale: widget.isMobile
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
                                  child: Icon(
                                    Icons.image_search_rounded,
                                    size: 80,
                                  ),
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
              Container(
                padding: EdgeInsets.all(10),
                height: widget.isMobile ? 60 : 110,
                width: double.maxFinite,
                color: Colors.black45,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.projectRowModel.name,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,

                      style: Fontstyle.sPrimaryFont(
                        widget.isMobile ? 22 : 28,
                        Colors.white,
                        FontWeight.normal,
                      ),
                    ),
                    if (!widget.isMobile)
                      Text(
                        widget.projectRowModel.subName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        maxLines: 2,
                        style: Fontstyle.subFont(
                          16,
                          Colors.white60,
                          FontWeight.normal,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
