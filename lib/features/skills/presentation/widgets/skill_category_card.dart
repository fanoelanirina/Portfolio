import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../models/skill_model.dart';

class SkillCategoryCard extends StatefulWidget {
  const SkillCategoryCard({super.key, required this.category});

  final SkillCategory category;

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final highlighted = category.badge != null;
    final p = context.palette;

    final borderColor = _hovered
        ? AppColors.accent
        : highlighted
        ? AppColors.accent.withValues(alpha: 0.45)
        : p.border;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(category: category),
            const SizedBox(height: 22),
            for (int i = 0; i < category.groups.length; i++) ...[
              if (i > 0) const SizedBox(height: 20),
              _GroupView(group: category.groups[i]),
            ],
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.category});

  final SkillCategory category;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(category.icon, color: AppColors.accent, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (category.badge != null) ...[
                Text(category.badge!.toUpperCase(), style: context.text.tag),
                const SizedBox(height: 4),
              ],
              Text(category.title, style: context.text.cardTitle),
            ],
          ),
        ),
      ],
    );
  }
}

class _GroupView extends StatelessWidget {
  const _GroupView({required this.group});

  final SkillGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (group.label != null) ...[
          Text(group.label!.toUpperCase(), style: context.text.menuNumber),
          const SizedBox(height: 10),
        ],
        if (group.isDetailed)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [for (final item in group.items) _SkillRow(item: item)],
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final item in group.items) _SkillChip(item: item)],
          ),
      ],
    );
  }
}

class _SkillRow extends StatelessWidget {
  const _SkillRow({required this.item});

  final SkillItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _SkillLogos(
                      assets: item.logoAssets,
                      height: 22,
                      spacing: 6,
                    ),
                    if (item.logoAssets.isNotEmpty) const SizedBox(width: 8),
                    Flexible(
                      child: Text(item.name, style: context.text.cardTitle),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(item.detail!, style: context.text.cardSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.item});

  final SkillItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.palette.borderStrong),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SkillLogos(assets: item.logoAssets, height: 20, spacing: 4),
          if (item.logoAssets.isNotEmpty) const SizedBox(width: 7),
          Text(item.name, style: context.text.chip),
        ],
      ),
    );
  }
}

class _SkillLogos extends StatelessWidget {
  const _SkillLogos({
    required this.assets,
    required this.height,
    required this.spacing,
  });

  final List<String> assets;
  final double height;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    if (assets.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < assets.length; i++) ...[
          if (i > 0) SizedBox(width: spacing),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              assets[i],
              height: height,
              width: height,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ],
    );
  }
}
