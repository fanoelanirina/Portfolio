import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../shared/widgets/reveal_on_scroll.dart';

class PassionsBlock extends StatelessWidget {
  const PassionsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final passions = [
      ('⚽', 'Football'),
      ('🎾', 'Tennis'),
      ('🏀', 'NBA'),
      ('♟️', context.tr('Échecs', 'Chess')),
      ('⚫', context.tr('Dames', 'Checkers')),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: Text(
            context.tr('Mes passions', 'My passions'),
            style: context.text.blockTitle,
          ),
        ),
        const SizedBox(height: 12),
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: Text(
            context.tr(
              'Quand j’ai un but, je fais tout pour l’atteindre, '
                  'sur le terrain comme devant un échiquier.',
              'When I have a goal, I go all in to reach it, '
                  'on the pitch as much as over a chessboard.',
            ),
            style: context.text.body,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (int i = 0; i < passions.length; i++)
              RevealOnScroll(
                delay: Duration(milliseconds: 200 + 80 * i),
                child: _PassionTile(
                  emoji: passions[i].$1,
                  label: passions[i].$2,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _PassionTile extends StatelessWidget {
  const _PassionTile({required this.emoji, required this.label});

  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.palette.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Text(label, style: context.text.chip),
        ],
      ),
    );
  }
}
