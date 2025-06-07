import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:app/core/theme/app_colors.dart'; // For styling controls

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    Uri? videoUri = Uri.tryParse(widget.videoUrl);
    if (videoUri != null && widget.videoUrl.isNotEmpty) { // Added isNotEmpty check
      _controller = VideoPlayerController.networkUrl(videoUri);
      _initializeVideoPlayerFuture = _controller.initialize().catchError((error) {
        // Handle initialization error, e.g., by setting a flag to show an error message
        if (mounted) {
          setState(() {
            // You could set an error message state here to display in the build method
            // print("Error initializing video player: $error");
          });
        }
        // It's good practice to rethrow or return a specific error state if needed higher up
        throw error; // Re-throw to be caught by FutureBuilder
      });
      _controller.setLooping(true); // Optional: example
    } else {
      // Handle invalid URL
       _initializeVideoPlayerFuture = Future.error(ArgumentError("Invalid video URL: ${widget.videoUrl}"));
    }
  }

  @override
  void dispose() {
    // Ensure controller is initialized before trying to dispose it, though in this structure it should be.
    // However, if initState throws before _controller is assigned, this could be an issue.
    // A null check or a flag could be added if initState could fail before _controller assignment.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError && _controller.value.isInitialized) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              VideoProgressIndicator(_controller, allowScrubbing: true),
              _buildControls(context),
            ],
          );
        } else if (snapshot.hasError || (snapshot.connectionState == ConnectionState.done && !_controller.value.isInitialized)) {
          return Center(
            child: Text(
              'Error loading video. Please check the URL or network connection.\nDetails: ${snapshot.error ?? "Video controller not initialized"}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildControls(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.5), // Semi-transparent background for controls
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.replay_10),
            color: Colors.white,
            onPressed: () {
              _controller.seekTo(_controller.value.position - const Duration(seconds: 10));
            },
          ),
          IconButton(
            icon: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
            color: Colors.white,
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.forward_10),
            color: Colors.white,
            onPressed: () {
              _controller.seekTo(_controller.value.position + const Duration(seconds: 10));
            },
          ),
        ],
      ),
    );
  }
}
