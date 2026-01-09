

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({super.key, required this.file});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    controller = VideoPlayerController.file(widget.file);
    await controller.initialize();
    setState(() {});
    controller.play(); // optional
  }


  @override
  Widget build(BuildContext context) {
    if(!controller.value.isInitialized){
      return CircularProgressIndicator();

    }
    return controller.value.isInitialized
        ? GestureDetector(
      onTap: () {
        setState(() {
          if (controller.value.isPlaying) {
            controller.pause();
          } else {
            controller.play();
          }
        });
      },
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Container(
          height: 400.h,
          width: double.infinity,

          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    )
        : CircularProgressIndicator();

  }
}

