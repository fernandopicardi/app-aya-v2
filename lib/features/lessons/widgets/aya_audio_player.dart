import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;
import '../../../core/theme/app_theme.dart';

class AyaAudioPlayer extends StatefulWidget {
  final String audioUrl;
  final String thumbnailUrl;

  const AyaAudioPlayer({
    super.key,
    required this.audioUrl,
    required this.thumbnailUrl,
  });

  @override
  State<AyaAudioPlayer> createState() => _AyaAudioPlayerState();
}

class _AyaAudioPlayerState extends State<AyaAudioPlayer>
    with SingleTickerProviderStateMixin {
  late AudioPlayer _player;
  bool _isInitialized = false;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  late AnimationController _waveformController;
  final List<double> _waveformData = List.generate(
    50,
    (index) => math.Random().nextDouble() * 0.5 + 0.2,
  );

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _waveformController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  Future<void> _initializePlayer() async {
    _player = AudioPlayer();
    try {
      await _player.setUrl(widget.audioUrl);
      setState(() {
        _isInitialized = true;
        _duration = _player.duration ?? Duration.zero;
      });

      // Listen to position changes
      _player.positionStream.listen((position) {
        if (mounted) {
          setState(() {
            _position = position;
          });
        }
      });

      // Listen to player state changes
      _player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
          });
        }
      });
    } catch (e) {
      debugPrint('Error initializing audio player: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AyaColors.lavenderSoft,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Thumbnail
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: widget.thumbnailUrl,
                fit: BoxFit.cover,
                width: double.infinity,
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
            ),
          ),

          // Audio Waveform
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AnimatedBuilder(
                animation: _waveformController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: WaveformPainter(
                      waveformData: _waveformData,
                      progress: _position.inMilliseconds /
                          (_duration.inMilliseconds == 0
                              ? 1
                              : _duration.inMilliseconds),
                      isPlaying: _isPlaying,
                      color: AyaColors.turquoise,
                    ),
                    size: Size.infinite,
                  );
                },
              ),
            ),
          ),

          // Controls
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Progress Bar
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 12,
                    ),
                    activeTrackColor: AyaColors.turquoise,
                    inactiveTrackColor: AyaColors.textPrimary.withOpacity(0.3),
                    thumbColor: AyaColors.turquoise,
                    overlayColor: AyaColors.turquoise.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: _position.inMilliseconds.toDouble(),
                    min: 0,
                    max: _duration.inMilliseconds.toDouble(),
                    onChanged: (value) {
                      _player.seek(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),

                // Time and Controls
                Row(
                  children: [
                    // Current Position
                    Text(
                      _formatDuration(_position),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AyaColors.textPrimary60,
                          ),
                    ),
                    const Spacer(),

                    // Previous 15s
                    IconButton(
                      icon: const Icon(
                        Icons.replay,
                        color: AyaColors.textPrimary,
                      ),
                      onPressed: () {
                        final newPosition =
                            _position - const Duration(seconds: 15);
                        _player.seek(newPosition.isNegative
                            ? Duration.zero
                            : newPosition);
                      },
                    ),

                    // Play/Pause
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause_circle : Icons.play_circle,
                        color: AyaColors.turquoise,
                        size: 48,
                      ),
                      onPressed: () {
                        if (_isPlaying) {
                          _player.pause();
                        } else {
                          _player.play();
                        }
                      },
                    ),

                    // Next 15s
                    IconButton(
                      icon: const Icon(
                        Icons.forward,
                        color: AyaColors.textPrimary,
                      ),
                      onPressed: () {
                        final newPosition =
                            _position + const Duration(seconds: 15);
                        if (newPosition <= _duration) {
                          _player.seek(newPosition);
                        }
                      },
                    ),
                    const Spacer(),

                    // Duration
                    Text(
                      _formatDuration(_duration),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AyaColors.textPrimary60,
                          ),
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

class WaveformPainter extends CustomPainter {
  final List<double> waveformData;
  final double progress;
  final bool isPlaying;
  final Color color;

  WaveformPainter({
    required this.waveformData,
    required this.progress,
    required this.isPlaying,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final barWidth = size.width / waveformData.length;
    final maxHeight = size.height * 0.8;

    for (var i = 0; i < waveformData.length; i++) {
      final x = i * barWidth;
      final height = waveformData[i] * maxHeight;
      final y = (size.height - height) / 2;

      // Draw the bar
      canvas.drawLine(
        Offset(x + barWidth / 2, y),
        Offset(x + barWidth / 2, y + height),
        paint,
      );

      // If this bar is before the progress point, make it more opaque
      if (i / waveformData.length < progress) {
        paint.color = color.withOpacity(0.8);
      } else {
        paint.color = color.withOpacity(0.3);
      }
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isPlaying != isPlaying ||
        oldDelegate.color != color;
  }
}
