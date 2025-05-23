import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

class _AyaAudioPlayerState extends State<AyaAudioPlayer> {
  final AudioPlayer _player = AudioPlayer();
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

      await _player.setUrl(widget.audioUrl);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao carregar o áudio. Tente novamente.';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
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
          // Thumbnail
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: widget.thumbnailUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 200,
                color: AyaColors.lavenderSoft,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AyaColors.turquoise,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                color: AyaColors.lavenderSoft,
                child: const Icon(
                  Icons.image_not_supported,
                  color: AyaColors.textPrimary,
                  size: 48,
                ),
              ),
            ),
          ),

          // Player Controls
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                  Column(
                    children: [
                      // Waveform Visualization
                      Container(
                        height: 60,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: StreamBuilder<Duration?>(
                          stream: _player.durationStream,
                          builder: (context, snapshot) {
                            final duration = snapshot.data ?? Duration.zero;
                            return StreamBuilder<Duration>(
                              stream: _player.positionStream,
                              builder: (context, snapshot) {
                                final position = snapshot.data ?? Duration.zero;
                                return StreamBuilder<PlayerState>(
                                  stream: _player.playerStateStream,
                                  builder: (context, snapshot) {
                                    final playerState = snapshot.data;
                                    final isPlaying =
                                        playerState?.playing ?? false;
                                    return CustomPaint(
                                      painter: WaveformPainter(
                                        position:
                                            position.inMilliseconds.toDouble(),
                                        duration:
                                            duration.inMilliseconds.toDouble(),
                                        isPlaying: isPlaying,
                                      ),
                                      size: const Size(double.infinity, 60),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),

                      // Progress Bar
                      StreamBuilder<Duration?>(
                        stream: _player.durationStream,
                        builder: (context, snapshot) {
                          final duration = snapshot.data ?? Duration.zero;
                          return StreamBuilder<Duration>(
                            stream: _player.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              final max = duration.inMilliseconds.toDouble();
                              final value = position.inMilliseconds
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
                                  value: value,
                                  min: 0.0,
                                  max: max > 0 ? max : 1.0,
                                  onChanged: max > 0
                                      ? (value) {
                                          _player.seek(Duration(
                                              milliseconds: value.toInt()));
                                        }
                                      : null,
                                ),
                              );
                            },
                          );
                        },
                      ),

                      // Time and Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Current Position
                          StreamBuilder<Duration>(
                            stream: _player.positionStream,
                            builder: (context, snapshot) {
                              final position = snapshot.data ?? Duration.zero;
                              return Text(
                                _formatDuration(position),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AyaColors.textPrimary40,
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
                                  final newPosition = _player.position -
                                      const Duration(seconds: 15);
                                  _player.seek(newPosition);
                                },
                              ),
                              StreamBuilder<PlayerState>(
                                stream: _player.playerStateStream,
                                builder: (context, snapshot) {
                                  final playerState = snapshot.data;
                                  final processingState =
                                      playerState?.processingState;
                                  final playing = playerState?.playing;

                                  if (processingState ==
                                          ProcessingState.loading ||
                                      processingState ==
                                          ProcessingState.buffering) {
                                    return Container(
                                      margin: const EdgeInsets.all(8.0),
                                      width: 32.0,
                                      height: 32.0,
                                      child: const CircularProgressIndicator(
                                        color: AyaColors.turquoise,
                                      ),
                                    );
                                  } else if (playing != true) {
                                    return IconButton(
                                      icon: const Icon(
                                        Icons.play_circle_filled,
                                        color: AyaColors.turquoise,
                                        size: 48,
                                      ),
                                      onPressed: _player.play,
                                    );
                                  } else {
                                    return IconButton(
                                      icon: const Icon(
                                        Icons.pause_circle_filled,
                                        color: AyaColors.turquoise,
                                        size: 48,
                                      ),
                                      onPressed: _player.pause,
                                    );
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.forward,
                                  color: AyaColors.textPrimary,
                                ),
                                onPressed: () {
                                  final newPosition = _player.position +
                                      const Duration(seconds: 15);
                                  _player.seek(newPosition);
                                },
                              ),
                            ],
                          ),

                          // Duration
                          StreamBuilder<Duration?>(
                            stream: _player.durationStream,
                            builder: (context, snapshot) {
                              final duration = snapshot.data ?? Duration.zero;
                              return Text(
                                _formatDuration(duration),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AyaColors.textPrimary40,
                                    ),
                              );
                            },
                          ),
                        ],
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
  final double position;
  final double duration;
  final bool isPlaying;

  WaveformPainter({
    required this.position,
    required this.duration,
    required this.isPlaying,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final progress = duration > 0 ? position / duration : 0.0;
    final progressWidth = size.width * progress;

    // Draw waveform
    final numberOfBars = 30;
    final barWidth = size.width / numberOfBars;
    final maxHeight = size.height * 0.8;

    for (var i = 0; i < numberOfBars; i++) {
      final x = i * barWidth;
      final height = maxHeight * (0.3 + 0.7 * (i % 3) / 2);
      final isActive = x < progressWidth;

      // Animate bars when playing
      final animationFactor = isPlaying ? 0.8 + 0.2 * (i % 3) / 2 : 1.0;
      final animatedHeight = height * animationFactor;

      paint.color = isActive ? AyaColors.turquoise : AyaColors.textPrimary40;

      canvas.drawLine(
        Offset(x + barWidth / 2, size.height / 2 - animatedHeight / 2),
        Offset(x + barWidth / 2, size.height / 2 + animatedHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(WaveformPainter oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.duration != duration ||
        oldDelegate.isPlaying != isPlaying;
  }
}
