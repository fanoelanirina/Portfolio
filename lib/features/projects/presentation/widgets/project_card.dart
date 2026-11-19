import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../shared/widgets/logo_badge.dart';
import '../../models/project_model.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, required this.onTap});

  final Project project;
  final VoidCallback onTap;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final p = context.palette;
    final text = context.text;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: p.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: _hovered ? AppColors.accent : p.border,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: _hovered ? 0.25 : 0),
                blurRadius: 32,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedScale(
                        scale: _hovered ? 1.1 : 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        child: LogoBadge(
                          asset: project.logoAsset,
                          fallback: project.logoFallback,
                          size: 72,
                        ),
                      ),
                      const _DemoBadge(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    project.category.toUpperCase(),
                    style: text.tag,
                  ),
                  const SizedBox(height: 8),
                  Text(project.title, style: text.blockTitle),
                  const SizedBox(height: 8),
                  Text(project.tagline, style: text.cardSubtitle),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tech in project.technologies.take(3))
                        _TechChip(label: tech),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              Row(
                children: [
                  Text(
                    context.tr('Voir le projet', 'View project'),
                    style: text.cardOrg,
                  ),
                  const SizedBox(width: 8),
                  AnimatedSlide(
                    offset: Offset(_hovered ? 0.5 : 0, 0),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.accent,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoBadge extends StatelessWidget {
  const _DemoBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_circle_outline, color: AppColors.accent, size: 16),
          SizedBox(width: 6),
          Text(
            context.tr('Démo', 'Demo'),
            style: context.text.tag.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  const _TechChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.palette.borderStrong),
      ),
      child: Text(label, style: context.text.chip.copyWith(fontSize: 12)),
    );
  }
}
