import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlay extends StatefulWidget {
  final String videoLink;
  const VideoPlay(this.videoLink,{Key key}) : super(key: key);
  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  VideoPlayerController _videoPlayerController;
  ChewieController _videoController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
        widget.videoLink);
    _videoController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: AspectRatio(
              aspectRatio: _videoController.aspectRatio,
              child: Chewie(
                controller: _videoController,
              )
          )
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _videoController.dispose();
    super.dispose();
  }
}