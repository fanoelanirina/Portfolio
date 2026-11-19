import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../shared/widgets/accent_text.dart';
import '../../../../shared/widgets/reveal_on_scroll.dart';

class PhilosophyBlock extends StatelessWidget {
  const PhilosophyBlock({super.key});

  static const _platforms = [
    (icon: Icons.android, label: 'Android'),
    (icon: Icons.phone_iphone, label: 'iOS'),
    (icon: Icons.language, label: 'Web'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: Text(
            context.tr('Ma philosophie de code', 'My coding philosophy'),
            style: context.text.blockTitle,
          ),
        ),
        const SizedBox(height: 16),
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: context.palette.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: context.palette.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '1',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w700,
                        height: 1,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'seule base de code pour Android, iOS et web : '
                        'c’est pourquoi je préfère Flutter.',
                        style: context.text.quote,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (int i = 0; i < _platforms.length; i++)
                      RevealOnScroll(
                        delay: Duration(milliseconds: 300 + 120 * i),
                        offset: const Offset(-0.2, 0),
                        child: _PlatformPill(
                          icon: _platforms[i].icon,
                          label: _platforms[i].label,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        RevealOnScroll(
          delay: const Duration(milliseconds: 250),
          child: AccentText(
            context.tr(
              'Mon stage chez Studio MG m’a orienté vers Flutter. '
                  '**Le conseil de mon encadreur :** choisir un seul domaine, '
                  'l’approfondir et se spécialiser sur un seul stack.',
              'My internship at Studio MG steered me towards Flutter. '
                  '**My supervisor’s advice:** pick a single field, '
                  'go deep, and specialize in a single stack.',
            ),
            style: context.text.body,
          ),
        ),
      ],
    );
  }
}

class _PlatformPill extends StatelessWidget {
  const _PlatformPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.accent),
          const SizedBox(width: 8),
          Text(label, style: context.text.chip),
        ],
      ),
    );
  }
}
