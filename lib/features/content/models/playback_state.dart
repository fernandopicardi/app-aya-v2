class PlaybackState {
  final Duration currentPosition;
  final Duration totalDuration;
  final bool isPlaying;

  const PlaybackState({
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.isPlaying = false,
  });
}