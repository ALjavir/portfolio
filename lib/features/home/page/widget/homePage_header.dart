import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/animation/TechBorderContainer_animation.dart';

import 'package:portfolio/animation/scrambleText_animation.dart';
import 'package:portfolio/animation/shiningText_animation.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';

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
  late final TextStyle baseStyle = Fontstyle.sPrimaryFont(
    MediaQuery.of(context).size.width < 768 ? 48 : 48,
    Colors.white,
    FontWeight.bold,

    //letterSpacing: -2.0,
  );

  late final TextStyle brandAccentStyle = baseStyle.copyWith(
    fontWeight: FontWeight.w900,
    color: const Color(0xFFE53935), // Signature red accent color
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,

      children: [
        TechbordercontainerAnimation(
          child:
              // LayeredWidgetKineticText(
              //   lines: [
              //     SuperkinetictextAnimation(
              //       child: Row(
              //         children: [
              //           Text("HI!", style: baseStyle),
              //           lottieImage(IconStyle.smile(), 46),
              //         ],
              //       ),
              //     ),
              //     SuperkinetictextAnimation(
              //       child: Text("I AM", style: baseStyle),
              //     ),
              //     SuperkinetictextAnimation(
              //       child: Text("AL JAVIR,", style: brandAccentStyle),
              //     ),
              //     SuperkinetictextAnimation(child: Text("A", style: baseStyle)),
              //     SuperkinetictextAnimation(
              //       child: Row(
              //         children: [
              //           SvgPicture.asset(
              //             IconStyle.flutter(),
              //             width: 38,
              //             height: 38,
              //           ),
              //           Text("FLUTTER", style: brandAccentStyle),
              //         ],
              //       ),
              //     ),
              //     SuperkinetictextAnimation(
              //       child: Text("DEVELOPER_.", style: baseStyle),
              //     ),
              //   ],
              // ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Fontstyle.sPrimaryFont(
                    48,
                    Theme.of(context).colorScheme.onSurface,
                    FontWeight.bold,
                  ),
                  children: [
                    //TextSpan(text: "''"),
                    TextSpan(text: "HI!"),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: lottieImage(IconStyle.smile(), 46),
                    ),

                    TextSpan(text: "  I AM "),

                    TextSpan(
                      text: "AL JAVIR",
                      style: Fontstyle.sPrimaryFont(
                        48,

                        ColorStyle.red,
                        FontWeight.bold,
                      ),
                    ),

                    TextSpan(text: "\nA "),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SvgPicture.asset(
                        IconStyle.flutter(),
                        width: 38,
                        height: 38,
                      ),
                    ),
                    TextSpan(
                      text: " FLUTTER",
                      style: Fontstyle.sPrimaryFont(
                        48,

                        ColorStyle.red,
                        FontWeight.bold,
                      ),
                    ),

                    TextSpan(text: " DEVELOPER_"),
                    TextSpan(
                      text: ".",
                      style: Fontstyle.primaryFont(
                        36,
                        Colors.red,
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
        ),

        ShiningtextAnimation(
          text: "Crafting sleek, scalable, and meaningful digital experiences.",

          style: Fontstyle.subFont(18, Colors.white, FontWeight.normal),
        ),
      ],
    );
  }
}
