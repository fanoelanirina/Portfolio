import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fait apparaître son contenu (fondu + glissement) quand il entre à l'écran.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 0.15),
  });

  final Widget child;
  final Duration delay;
  final Offset offset;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  final Key _detectorKey = UniqueKey();
  bool _triggered = false;
  bool _visible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.15) return;
    _triggered = true;
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : widget.offset,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}
