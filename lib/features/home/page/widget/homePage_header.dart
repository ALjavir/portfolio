import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:portfolio/animation/shiningText_animation.dart';

import 'package:portfolio/style/color_style.dart';
import 'package:portfolio/style/font_style.dart';
import 'package:portfolio/style/icon_style.dart';
import 'package:portfolio/theme/gWidget/global_widget.dart';

class HomepageHeader extends StatefulWidget {
  const HomepageHeader({super.key});

  @override
  State<HomepageHeader> createState() => _HomepageHeaderState();
}

class _HomepageHeaderState extends State<HomepageHeader> {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,

      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Fontstyle.sPrimaryFont(
              isMobile(context) ? 36 : 48,
              Theme.of(context).colorScheme.onSurface,
              FontWeight.bold,
            ),
            children: [
              //TextSpan(text: "''"),
              TextSpan(text: "HI!"),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: lottieImage(
                  IconStyle.smile(),
                  isMobile(context) ? 36 : 46,
                ),
              ),

              TextSpan(text: "  I AM "),

              TextSpan(
                text: "AL JAVIR,",
                style: Fontstyle.sPrimaryFont(
                  isMobile(context) ? 36 : 48,
                  Colors.red,
                  FontWeight.bold,
                ),
              ),

              TextSpan(text: "\nA "),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: SvgPicture.asset(
                  IconStyle.flutter(),
                  width: isMobile(context) ? 28 : 38,
                  height: isMobile(context) ? 28 : 38,
                ),
              ),
              TextSpan(
                text: " FLUTTER",
                style: Fontstyle.sPrimaryFont(
                  isMobile(context) ? 36 : 48,
                  Colors.red,
                  FontWeight.bold,
                ),
              ),

              TextSpan(text: " DEVELOPER_"),
              TextSpan(
                text: ".",
                style: Fontstyle.primaryFont(36, Colors.red, FontWeight.bold),
              ),
            ],
          ),
        ),

        ShiningtextAnimation(
          text: "Crafting sleek, scalable, and meaningful digital experiences.",

          style: Fontstyle.subFont(
            isMobile(context) ? 16 : 18,
            Colors.white,
            FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
