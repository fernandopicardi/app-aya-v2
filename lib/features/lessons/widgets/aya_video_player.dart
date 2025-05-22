import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_theme.dart';

class AyaVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  const AyaVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  State<AyaVideoPlayer> createState() => _AyaVideoPlayerState();
}

class _AyaVideoPlayerState extends State<AyaVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _showControls = true;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = VideoPlayerController.network(widget.videoUrl);
    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing video player: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Video or Thumbnail
          if (_isInitialized)
            GestureDetector(
              onTap: () {
                setState(() {
                  _showControls = !_showControls;
                });
              },
              child: VideoPlayer(_controller),
            )
          else
            CachedNetworkImage(
              imageUrl: widget.thumbnailUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AyaColors.lavenderSoft,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AyaColors.turquoise,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: AyaColors.lavenderSoft,
                child: const Icon(
                  Icons.image_not_supported,
                  color: AyaColors.textPrimary,
                  size: 48,
                ),
              ),
            ),

          // Play Button (when not playing)
          if (_isInitialized && !_controller.value.isPlaying)
            Center(
              child: IconButton(
                icon: const Icon(
                  Icons.play_circle_fill,
                  color: AyaColors.turquoise,
                  size: 64,
                ),
                onPressed: () {
                  _controller.play();
                },
              ),
            ),

          // Controls Overlay
          if (_showControls && _isInitialized)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: AyaColors.textPrimary,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFullScreen = !_isFullScreen;
                            });
                            // TODO: Implement fullscreen toggle
                          },
                        ),
                      ],
                    ),
                  ),

                  // Bottom Bar
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Progress Bar
                        ValueListenableBuilder(
                          valueListenable: _controller,
                          builder: (context, VideoPlayerValue value, child) {
                            return SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 12,
                                ),
                                activeTrackColor: AyaColors.turquoise,
                                inactiveTrackColor:
                                    AyaColors.textPrimary.withOpacity(0.3),
                                thumbColor: AyaColors.turquoise,
                                overlayColor:
                                    AyaColors.turquoise.withOpacity(0.2),
                              ),
                              child: Slider(
                                value: value.position.inMilliseconds.toDouble(),
                                min: 0,
                                max: value.duration.inMilliseconds.toDouble(),
                                onChanged: (newValue) {
                                  _controller.seekTo(
                                    Duration(
                                      milliseconds: newValue.toInt(),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        // Controls
                        Row(
                          children: [
                            // Play/Pause
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: AyaColors.textPrimary,
                              ),
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

                            // Current Position / Duration
                            ValueListenableBuilder(
                              valueListenable: _controller,
                              builder:
                                  (context, VideoPlayerValue value, child) {
                                return Text(
                                  '${_formatDuration(value.position)} / ${_formatDuration(value.duration)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: AyaColors.textPrimary,
                                      ),
                                );
                              },
                            ),

                            const Spacer(),

                            // Volume
                            IconButton(
                              icon: Icon(
                                _controller.value.volume > 0
                                    ? Icons.volume_up
                                    : Icons.volume_off,
                                color: AyaColors.textPrimary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.setVolume(
                                    _controller.value.volume > 0 ? 0 : 1,
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }
}
