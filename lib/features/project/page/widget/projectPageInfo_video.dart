import 'package:flutter/material.dart';
import 'package:portfolio/animation/smoothRevealWidget_animation.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class ProjectpageinfoVideo extends StatefulWidget {
  final String videoLink;
  const ProjectpageinfoVideo({super.key, required this.videoLink});

  @override
  State<ProjectpageinfoVideo> createState() => _ProjectpageinfoVideoState();
}

class _ProjectpageinfoVideoState extends State<ProjectpageinfoVideo> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // 1. Parse the full link to extract just the ID string ('KRyTtdjijj8')
    final String? parsedVideoId = YoutubePlayerController.convertUrlToId(
      widget.videoLink,
    );

    // 2. Initialize using the cleaned ID
    _controller = YoutubePlayerController.fromVideoId(
      videoId:
          parsedVideoId ??
          'KRyTtdjijj8', // Fallback to a default ID if parsing fails
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SmoothrevealwidgetAnimation(
      delay: const Duration(milliseconds: 3500),
      child: Card(
        surfaceTintColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,

        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,

        elevation: 10,
        child: Container(
          alignment: Alignment.topCenter, // Fixed AlignmentGeometry warning
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: YoutubePlayer(controller: _controller, aspectRatio: 16 / 9),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
