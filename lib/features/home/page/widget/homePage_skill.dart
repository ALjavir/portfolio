import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';
import 'package:portfolio/features/home/controller/homePage_controller.dart';
import 'package:portfolio/features/home/model/home_model.dart';
import 'package:portfolio/style/color_style.dart';
import 'package:portfolio/style/font_style.dart';
import 'package:portfolio/style/icon_style.dart';
import 'package:portfolio/theme/gWidget/global_widget.dart';

class HomepageSkill extends StatefulWidget {
  const HomepageSkill({super.key});

  @override
  State<HomepageSkill> createState() => _HomepageSkillState();
}

class _HomepageSkillState extends State<HomepageSkill> {
  //  late Future<List<skillModelHome>> logoData;

  final homepageController = HomepageController();

  // @override
  // void initState() {
  //   super.initState();
  //   logoData = Future.delayed(
  //     const Duration(milliseconds: 1500),
  //     () => homepageController.fetchSkillData(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: homepageController.logoData,

          builder: (context, snapshot) {
            // LOADING
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: lottieImage(IconStyle.primaryLoading(), 180),
              );
            }

            // ERROR
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data!.isEmpty) {
              return Center(child: lottieImage(IconStyle.error(), 180));
            }

            final skills = snapshot.data!;

            // SUCCESS
            return SmoothrevealwidgetAnimation(
              delay: Duration(seconds: 3),
              child: LogoCloudSlider(logos: skills),
            );
          },
        ),
      ],
    );
  }
}

class LogoCloudSlider extends StatefulWidget {
  final List<skillModelHome> logos;
  // final double gap;
  // final double normalSpeed;
  // final double hoverSpeed;

  const LogoCloudSlider({
    super.key,
    required this.logos,
    // this.gap = 42.0,
    // this.normalSpeed = 1.0,
    // this.hoverSpeed = 0.3,
  });

  @override
  State<LogoCloudSlider> createState() => _LogoCloudSliderState();
}

class _LogoCloudSliderState extends State<LogoCloudSlider> {
  late ScrollController _scrollController;
  Timer? _timer;

  final _currentSpeed = 0.0.obs;
  final RxInt _direction = 1.obs;

  final double _initialScrollOffset = 10000.0;

  @override
  void initState() {
    super.initState();
    _currentSpeed.value = 1.0;
    _scrollController = ScrollController(
      initialScrollOffset: _initialScrollOffset,
    );

    // Start the auto-scroll loop
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer?.cancel();
    // Running at ~60fps
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_scrollController.hasClients) {
        RxDouble currentScroll = _scrollController.offset.obs;
        double delta = _currentSpeed.value * _direction.value;
        _scrollController.jumpTo(currentScroll.value + delta);
      }
    });
  }

  // void startAutoScroll() {
  //   _timer?.cancel();
  //   _timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
  //     if (_scrollController.hasClients) {
  //       double currentScroll = _scrollController.offset;
  //       double targetScroll = currentScroll + _direction;

  //       if (targetScroll <= 5000.0 && _direction < 0) {
  //         _scrollController.jumpTo(20000.0);
  //         targetScroll = 20000.0 + _direction;
  //       } else if (targetScroll >= 35000.0 && _direction > 0) {
  //         _scrollController.jumpTo(20000.0);
  //         targetScroll = 20000.0 + _direction;
  //       }

  //       _scrollController.animateTo(
  //         targetScroll,
  //         duration: const Duration(milliseconds: 600),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  // }

  void _manualScroll(int newDirection) {
    _direction.value = newDirection;
    _currentSpeed.value = 1.0; // Reset speed in case it was hovering

    // Give a little manual "bump" jump for immediate feedback when clicking
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset + (150.0 * newDirection),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  Color powerdByColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. The Scrolling Content wrapped in MouseRegion for hover detection
        MouseRegion(
          onEnter: (_) => setState(() {
            _currentSpeed.value = 0.3;
            powerdByColor = Colors.red;
          }),

          onExit: (_) => setState(() {
            _currentSpeed.value = 1;
            powerdByColor = Colors.white;
          }),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                ],
                stops: [
                  0.0,
                  0.05,
                  0.25,
                  0.75,
                  0.95,
                  1.0,
                ], // Controls how wide the blur/fade is
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  height: 110,
                  //alignment: AlignmentGeometry.center,
                  constraints: const BoxConstraints(maxWidth: 1000),
                  // padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    border: const Border(
                      //  top: BorderSide(color: Colors.white30, width: 0.5),
                      //  bottom: BorderSide(color: Colors.white30, width: 0.5),
                    ),
                    boxShadow: [
                      // BoxShadow(
                      //   blurStyle: BlurStyle.inner,
                      //   color: Colors.grey.shade900,
                      //   spreadRadius: 0,
                      //   blurRadius: 0,
                      // ),
                    ],
                  ),
                  child: ListView.builder(
                    controller: _scrollController,

                    scrollDirection: Axis.horizontal,

                    itemCount: null,

                    physics: const NeverScrollableScrollPhysics(),

                    itemBuilder: (context, index) {
                      final logoIndex = index % widget.logos.length;
                      final skill = widget.logos[logoIndex];

                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 8,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.network(
                                skill.image,

                                width: 45,

                                height: 45,

                                placeholderBuilder: (context) => SizedBox(
                                  width: 50,

                                  height: 50,

                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),

                                errorBuilder: (context, error, stack) =>
                                    const Icon(
                                      Icons.broken_image_rounded,

                                      color: ColorStyle.red,
                                    ),
                              ),

                              Text(
                                skill.name,

                                style: Fontstyle.subFont(
                                  14,

                                  Colors.white60,

                                  FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SmoothrevealwidgetAnimation(
                  delay: Duration(seconds: 4),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "</ ",

                          style: Fontstyle.subFont(
                            20,
                            isMobile(context) ? Colors.red : powerdByColor,
                            FontWeight.w900,
                          ),
                        ),

                        TextSpan(
                          text: "POWERED BY",

                          style: Fontstyle.sPrimaryFont(
                            20,

                            Theme.of(context).colorScheme.onSurface,

                            FontWeight.w500,
                          ),
                        ),

                        TextSpan(
                          text: " >",

                          style: Fontstyle.subFont(
                            20,
                            isMobile(context) ? Colors.red : powerdByColor,
                            FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // 3. Left Control Button
        Positioned(
          left: 0,
          top: 30,
          child: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.white70,
              size: 30,
            ),
            hoverColor: Colors.white10,
            onPressed: () => _manualScroll(-1), // Scroll Left
          ),
        ),

        // 4. Right Control Button
        Positioned(
          right: 0,
          top: 30,
          child: IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.white70,
              size: 30,
            ),
            hoverColor: Colors.white10,
            onPressed: () => _manualScroll(1), // Scroll Right
          ),
        ),
      ],
    );
  }
}
