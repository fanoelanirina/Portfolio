import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../shared/widgets/logo_badge.dart';
import '../../models/project_model.dart';
import 'project_video_player.dart';

Future<void> showProjectDetail(BuildContext context, Project project) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: context.tr('Fermer', 'Close'),
    barrierColor: Colors.black.withValues(alpha: 0.85),
    transitionDuration: const Duration(milliseconds: 450),
    pageBuilder: (context, animation, secondary) =>
        ProjectDetailDialog(project: project),
    transitionBuilder: (context, animation, secondary, child) {
      final curved = animation.drive(CurveTween(curve: Curves.easeOutCubic));
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: curved.drive(
            Tween(begin: const Offset(0, 0.08), end: Offset.zero),
          ),
          child: ScaleTransition(
            scale: curved.drive(Tween(begin: 0.94, end: 1.0)),
            child: child,
          ),
        ),
      );
    },
  );
}

class ProjectDetailDialog extends StatelessWidget {
  const ProjectDetailDialog({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = Responsive.isMobile(context);
    final palette = context.palette;

    final video = ProjectVideoPlayer(asset: project.videoAsset);
    final info = _ProjectInfo(project: project);

    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12 : 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1050,
              maxHeight: size.height * 0.92,
            ),
            child: Material(
              color: palette.surface,
              borderRadius: BorderRadius.circular(28),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(isMobile ? 20 : 32),
                    child: isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [video, const SizedBox(height: 24), info],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 6, child: video),
                              const SizedBox(width: 32),
                              Expanded(flex: 5, child: info),
                            ],
                          ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: palette.textPrimary),
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

class _ProjectInfo extends StatelessWidget {
  const _ProjectInfo({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Row(
            children: [
              LogoBadge(
                asset: project.logoAsset,
                fallback: project.logoFallback,
                size: 56,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.category.toUpperCase(),
                      style: text.tag,
                    ),
                    const SizedBox(height: 4),
                    Text(project.title, style: text.blockTitle),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(project.description, style: text.body),
        const SizedBox(height: 20),
        for (final feature in project.features)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: AppColors.accent,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(feature, style: text.cardSubtitle),
                ),
              ],
            ),
          ),
        if (project.role != null) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(project.role!, style: text.cardSubtitle),
          ),
        ],
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tech in project.technologies)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: p.borderStrong),
                ),
                child: Text(
                  tech,
                  style: text.chip.copyWith(fontSize: 12),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
