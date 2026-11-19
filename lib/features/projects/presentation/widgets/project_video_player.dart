import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/settings/app_settings.dart';

class ProjectVideoPlayer extends StatefulWidget {
  const ProjectVideoPlayer({super.key, required this.asset});

  final String asset;

  @override
  State<ProjectVideoPlayer> createState() => _ProjectVideoPlayerState();
}

class _ProjectVideoPlayerState extends State<ProjectVideoPlayer> {
  late final VideoPlayerController _controller;
  bool _ready = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.asset);
    _controller
        .initialize()
        .then((_) {
          if (!mounted) return;
          _controller.setLooping(true);
          setState(() => _ready = true);
        })
        .catchError((Object error) {
          if (mounted) setState(() => _failed = true);
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return _VideoPlaceholder(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.videocam_off_outlined, color: Colors.white38, size: 40),
            SizedBox(height: 10),
            Text(
              context.tr(
                'Vidéo de démonstration à ajouter',
                'Demo video coming soon',
              ),
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        ),
      );
    }

    if (!_ready) {
      return const _VideoPlaceholder(
        child: CircularProgressIndicator(color: AppColors.accent),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        color: Colors.black,
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 440),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: GestureDetector(
              onTap: _togglePlay,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  ValueListenableBuilder<VideoPlayerValue>(
                    valueListenable: _controller,
                    builder: (context, value, _) => AnimatedOpacity(
                      opacity: value.isPlaying ? 0 : 1,
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 44,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: AppColors.accent,
                        bufferedColor: Colors.white24,
                        backgroundColor: Colors.white10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoPlaceholder extends StatelessWidget {
  const _VideoPlaceholder({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
