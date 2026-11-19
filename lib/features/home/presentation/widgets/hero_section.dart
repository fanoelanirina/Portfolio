import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../core/utils/cv_downloader.dart';
import '../../../../shared/widgets/custom_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, this.onContactTap});

  final VoidCallback? onContactTap;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _photoTimer;
  int _photoIndex = 0;

  static const List<String> _photos = [
    'assets/images/profile.png',
    'assets/images/profile_2.png',
  ];
  static const Duration _photoInterval = Duration(seconds: 4);

  static const ColorFilter _grayscale = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    _photoTimer = Timer.periodic(_photoInterval, (_) {
      if (!mounted) return;
      setState(() => _photoIndex = (_photoIndex + 1) % _photos.length);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final path in _photos) {
      precacheImage(AssetImage(path), context);
    }
  }

  @override
  void dispose() {
    _photoTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  /// Apparition : fondu + glissement, sur un intervalle de l'animation globale.
  Widget _reveal({
    required double start,
    required double end,
    required Widget child,
    Offset offset = const Offset(0, 0.3),
  }) {
    final anim = _controller.drive(
      CurveTween(curve: Interval(start, end, curve: Curves.easeOutCubic)),
    );
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: anim.drive(Tween(begin: offset, end: Offset.zero)),
        child: child,
      ),
    );
  }

  /// Fondu doux sur les quatre bords pour intégrer la photo à la page.
  Widget _softEdges(Widget child) {
    Widget mask(Widget child, Axis axis, List<double> stops) => ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) => LinearGradient(
        begin: axis == Axis.horizontal
            ? Alignment.centerLeft
            : Alignment.topCenter,
        end: axis == Axis.horizontal
            ? Alignment.centerRight
            : Alignment.bottomCenter,
        colors: const [
          Colors.transparent,
          Colors.white,
          Colors.white,
          Colors.transparent,
        ],
        stops: stops,
      ).createShader(rect),
      child: child,
    );

    return mask(
      mask(child, Axis.horizontal, const [0.0, 0.2, 0.8, 1.0]),
      Axis.vertical,
      const [0.0, 0.15, 0.78, 1.0],
    );
  }

  Widget _photo(double maxWidth, double maxHeight) {
    final anim = _controller.drive(
      CurveTween(curve: const Interval(0.1, 0.8, curve: Curves.easeOutCubic)),
    );
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: anim.drive(
          Tween(begin: const Offset(0, 0.12), end: Offset.zero),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          layoutBuilder: (currentChild, previousChildren) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          ),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: Tween(begin: 0.97, end: 1.0).animate(animation),
              child: child,
            ),
          ),
          child: KeyedSubtree(
            key: ValueKey(_photoIndex),
            child: ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: anim.drive(Tween(begin: 1.06, end: 1.0)),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: _softEdges(
                  ColorFiltered(
                    colorFilter: _grayscale,
                    child: Image.asset(
                      _photos[_photoIndex],
                      height: maxHeight,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _content({
    required bool isCompactMobile,
    required double nameSize,
    required double roleSize,
    required double greetingSize,
    required double buttonScale,
    required double spacingScale,
    required bool isMobile,
  }) {
    final text = context.text;
    return [
      _reveal(
        start: 0.15,
        end: 0.45,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.tr('SALUT !', 'HELLO!'),
              style: text.greeting.copyWith(fontSize: greetingSize),
            ),
            SizedBox(width: 8 * spacingScale),
            _WavingHand(controller: _controller, size: greetingSize * 1.15),
          ],
        ),
      ),
      SizedBox(height: (isCompactMobile ? 4 : 10) * spacingScale),

      _reveal(
        start: 0.25,
        end: 0.6,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'Fanoela Nirina\nRAKOTOMALALA',
            softWrap: false,
            style: text
                .name(nameSize)
                .copyWith(
                  shadows: const [
                    Shadow(color: Colors.black38, blurRadius: 24),
                  ],
                ),
          ),
        ),
      ),
      SizedBox(height: (isCompactMobile ? 8 : 14) * spacingScale),

      _reveal(
        start: 0.35,
        end: 0.7,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              color: AppColors.accent,
              size: roleSize * 1.1,
            ),
            SizedBox(width: 6 * spacingScale),
            Text(
              context.tr('Développeur Flutter', 'Flutter Developer'),
              style: text.role(roleSize),
            ),
          ],
        ),
      ),
      SizedBox(height: (isCompactMobile ? 12 : 32) * spacingScale),

      _reveal(
        start: 0.5,
        end: 0.85,
        child: Wrap(
          spacing: 12 * spacingScale,
          runSpacing: 12 * spacingScale,
          children: [
            CustomButton(
              label: context.tr('Me contacter', 'Contact me'),
              icon: Icons.mail_outline,
              scale: buttonScale,
              onPressed: widget.onContactTap,
            ),
            CustomButton(
              label: context.tr('Télécharger mon CV', 'Download my CV'),
              icon: Icons.download_rounded,
              filled: false,
              scale: buttonScale,
              fontSize: 15,
              foregroundColor: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.accent
                  : null,
              onPressed: () => CvDownloader.download(context),
            ),
          ],
        ),
      ),

      if (isMobile) SizedBox(height: (isCompactMobile ? 4 : 20) * spacingScale),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final device = Responsive.of(context);
    final isMobile = device == DeviceType.mobile;
    final isCompactMobile = isMobile && size.height < 500;

    final width = size.width;
    final height = size.height;
    final spacingScale = (width / 1200).clamp(1.0, 1.6).toDouble();
    final nameSize = isMobile
        ? (width * 0.105).clamp(38.0, 56.0).toDouble()
        : (width * 0.05).clamp(38.0, 96.0).toDouble();
    final roleSize = isMobile
        ? 22.0
        : (width * 0.022).clamp(22.0, 40.0).toDouble();
    final greetingSize = (width * 0.011).clamp(16.0, 24.0).toDouble();
    final buttonScale = (width / 1100).clamp(1.0, 1.5).toDouble();
    final horizontalPadding = isMobile ? 24.0 : size.width * 0.08;
    final topPadding = (height * 0.11).clamp(90.0, 150.0).toDouble();
    final tabletProgress = ((width - 600) / 424).clamp(0.0, 1.0).toDouble();
    final photoMaxHeight = height * (0.58 + 0.22 * tabletProgress);
    final photoMaxWidth = width * (0.92 - 0.54 * tabletProgress);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: context.palette.background,
      child: Stack(
        children: [
          // Photo centrée en bas, adaptée à la taille de l'écran.
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _photo(photoMaxWidth, photoMaxHeight),
            ),
          ),

          // Contenu texte
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                28 * spacingScale,
              ),
              child: isMobile
                  // Mobile : on scrolle pour ne jamais overflow
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _content(
                          isCompactMobile: isCompactMobile,
                          nameSize: nameSize,
                          roleSize: roleSize,
                          greetingSize: greetingSize,
                          buttonScale: buttonScale,
                          spacingScale: spacingScale,
                          isMobile: true,
                        ),
                      ),
                    )
                  // Tablette / desktop : Column classique avec Spacer
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _content(
                        isCompactMobile: isCompactMobile,
                        nameSize: nameSize,
                        roleSize: roleSize,
                        greetingSize: greetingSize,
                        buttonScale: buttonScale,
                        spacingScale: spacingScale,
                        isMobile: false,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Main qui salue : petite rotation de balancier.
class _WavingHand extends StatelessWidget {
  const _WavingHand({required this.controller, required this.size});

  final Animation<double> controller;
  final double size;

  @override
  Widget build(BuildContext context) {
    final turns = controller
        .drive(CurveTween(curve: const Interval(0.3, 0.75)))
        .drive(
          TweenSequence<double>([
            TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.12), weight: 1),
            TweenSequenceItem(tween: Tween(begin: 0.12, end: -0.05), weight: 1),
            TweenSequenceItem(tween: Tween(begin: -0.05, end: 0.12), weight: 1),
            TweenSequenceItem(tween: Tween(begin: 0.12, end: 0.0), weight: 1),
          ]),
        );

    return RotationTransition(
      turns: turns,
      alignment: Alignment.bottomRight,
      child: Text('👋', style: TextStyle(fontSize: size)),
    );
  }
}
