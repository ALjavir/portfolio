import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';
import 'package:portfolio/style/color_style.dart';
import 'package:portfolio/style/font_style.dart';

class ProjectpageinfoImage extends StatefulWidget {
  final Map<String, dynamic> page;
  const ProjectpageinfoImage({super.key, required this.page});

  @override
  State<ProjectpageinfoImage> createState() => _ProjectpageinfoDetailState();
}

class _ProjectpageinfoDetailState extends State<ProjectpageinfoImage> {
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.page.length,
        itemBuilder: (context, index) {
          final pageImage = widget.page.entries.toList()
            ..sort(
              (a, b) =>
                  (a.value["index"] as num).compareTo(b.value["index"] as num),
            );
          if (isMobile(context)) {
            return SmoothrevealwidgetAnimation(
              delay: const Duration(milliseconds: 4000),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(pageImage[index].key, pageImage[index].value['index']),

                  showImage(pageImage[index].value['image'], 1),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: Text(
                      pageImage[index].value['text'],

                      style: Fontstyle.subFont(
                        18,

                        Theme.of(context).colorScheme.onSurface.withAlpha(150),

                        FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            final bool isEven = index % 2 == 0;

            final Widget imageWidget = showImage(
              pageImage[index].value['image'],
              2.5,
            );

            final Widget textWidget = Expanded(
              child: Column(
                crossAxisAlignment: isEven
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,

                children: [
                  title(pageImage[index].key, pageImage[index].value['index']),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 800,
                    child: Text(
                      pageImage[index].value['text'],
                      softWrap: true,
                      textAlign: isEven ? TextAlign.left : TextAlign.right,
                      style: Fontstyle.subFont(
                        18,
                        Theme.of(context).colorScheme.onSurface.withAlpha(150),
                        FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            );

            return SmoothrevealwidgetAnimation(
              delay: const Duration(milliseconds: 4000),
              child: Padding(
                padding: const EdgeInsets.all(80),
                child: Row(
                  spacing: 40,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: isEven
                      ? [imageWidget, textWidget]
                      : [textWidget, imageWidget],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget showImage(String img, double scal) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      surfaceTintColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,

      shadowColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,

      elevation: 10,
      //
      child: Stack(
        alignment: AlignmentGeometry.topRight,
        children: [
          CachedNetworkImage(
            imageUrl: img,
            scale: scal,

            placeholder: (_, _) => Padding(
              padding: const EdgeInsets.all(80),
              child: Center(child: Icon(Icons.image_search_rounded, size: 80)),
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
          IconButton(
            padding: const EdgeInsets.all(8),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.black54,

                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    insetAnimationCurve: Curves.bounceIn,

                    child: Stack(
                      alignment: Alignment.topRight,

                      children: [
                        InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 5,

                          child: CachedNetworkImage(
                            imageUrl: img,

                            fit: BoxFit.contain,

                            placeholder: (_, _) => const Center(
                              child: CircularProgressIndicator(),
                            ),

                            errorWidget: (_, _, _) => const Icon(
                              Icons.broken_image_rounded,
                              color: Colors.red,
                              size: 80,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            splashColor: Colors.white,
            focusColor: Colors.white,

            icon: const Icon(Icons.zoom_in, color: Colors.white, size: 35),
          ),
        ],
      ),
    );
  }

  Widget title(String name, int index) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: index.toString().padLeft(2, '0'),
            style: Fontstyle.subFont(
              26,
              Theme.of(context).colorScheme.onSurface,
              FontWeight.normal,
            ),
          ),

          TextSpan(
            text: " // ",
            style: Fontstyle.subFont(26, Colors.red, FontWeight.w900),
          ),
          TextSpan(
            text: name,
            style: Fontstyle.navBarFont(
              26,

              Theme.of(context).colorScheme.onSurface,

              FontWeight.normal,
            ),
          ),
          TextSpan(
            text: ".",
            style: Fontstyle.subFont(26, Colors.red, FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
