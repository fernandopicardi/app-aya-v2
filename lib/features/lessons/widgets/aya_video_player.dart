import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      _controller =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      await _controller.initialize();

      setState(() {
        _isInitialized = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao carregar o vídeo. Tente novamente.';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AyaColors.lavenderSoft,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Video Player
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: AyaColors.turquoise,
                    ),
                  )
                else if (_errorMessage != null)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: AyaColors.textPrimary,
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AyaColors.textPrimary,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _initializePlayer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AyaColors.turquoise,
                            foregroundColor: AyaColors.surface,
                          ),
                          child: const Text('Tentar Novamente'),
                        ),
                      ],
                    ),
                  )
                else
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, VideoPlayerValue value, child) {
                          if (!value.isPlaying) {
                            return IconButton(
                              icon: const Icon(
                                Icons.play_circle_filled,
                                color: AyaColors.turquoise,
                                size: 64,
                              ),
                              onPressed: () {
                                _controller.play();
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),

          // Controls
          if (_isInitialized && _errorMessage == null)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Progress Bar
                  ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (context, VideoPlayerValue value, child) {
                      final duration = value.duration;
                      final position = value.position;
                      final max = duration.inMilliseconds.toDouble();
                      final current = position.inMilliseconds
                          .toDouble()
                          .clamp(0.0, max > 0 ? max : 1.0);

                      return SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 12,
                          ),
                          activeTrackColor: AyaColors.turquoise,
                          inactiveTrackColor: AyaColors.textPrimary40,
                          thumbColor: AyaColors.turquoise,
                          overlayColor: AyaColors.textPrimary40,
                        ),
                        child: Slider(
                          value: current,
                          min: 0.0,
                          max: max > 0 ? max : 1.0,
                          onChanged: max > 0
                              ? (value) {
                                  _controller.seekTo(
                                      Duration(milliseconds: value.toInt()));
                                }
                              : null,
                        ),
                      );
                    },
                  ),

                  // Time and Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Current Position
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, VideoPlayerValue value, child) {
                          return Text(
                            _formatDuration(value.position),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AyaColors.textPrimary60,
                                    ),
                          );
                        },
                      ),

                      // Controls
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.replay,
                              color: AyaColors.textPrimary,
                            ),
                            onPressed: () {
                              final newPosition = _controller.value.position -
                                  const Duration(seconds: 15);
                              _controller.seekTo(newPosition);
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: _controller,
                            builder: (context, VideoPlayerValue value, child) {
                              return IconButton(
                                icon: Icon(
                                  value.isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_filled,
                                  color: AyaColors.turquoise,
                                  size: 48,
                                ),
                                onPressed: () {
                                  if (value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.forward,
                              color: AyaColors.textPrimary,
                            ),
                            onPressed: () {
                              final newPosition = _controller.value.position +
                                  const Duration(seconds: 15);
                              _controller.seekTo(newPosition);
                            },
                          ),
                        ],
                      ),

                      // Duration
                      ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, VideoPlayerValue value, child) {
                          return Text(
                            _formatDuration(value.duration),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AyaColors.textPrimary60,
                                    ),
                          );
                        },
                      ),
                    ],
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
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
