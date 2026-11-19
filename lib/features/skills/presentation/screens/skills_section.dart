import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../shared/widgets/accent_text.dart';
import '../../../../shared/widgets/reveal_on_scroll.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../data/skills_data.dart';
import '../widgets/skill_category_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final device = Responsive.of(context);
    final isMobile = device == DeviceType.mobile;
    final categories = buildSkillCategories(context.isFr);

    final headlineSize = switch (device) {
      DeviceType.mobile => 26.0,
      DeviceType.tablet => 32.0,
      DeviceType.desktop => 38.0,
    };

    Widget card(int index, int delayMs) => RevealOnScroll(
      delay: Duration(milliseconds: delayMs),
      child: SkillCategoryCard(category: categories[index]),
    );

    Widget row(int a, int b, int flexA, int flexB) => IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: flexA, child: card(a, 0)),
          const SizedBox(width: 20),
          Expanded(flex: flexB, child: card(b, 150)),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      color: context.palette.background,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.08,
        vertical: isMobile ? 64 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RevealOnScroll(
                child: SectionTitle(
                  number: '02',
                  title: context.tr('Compétences', 'Skills'),
                ),
              ),
              const SizedBox(height: 24),
              RevealOnScroll(
                delay: const Duration(milliseconds: 100),
                child: AccentText(
                  context.tr(
                    'Spécialisé en **Flutter**, renforcé par **l’IA**.',
                    'Specialized in **Flutter**, strengthened by **AI**.',
                  ),
                  style: context.text.sectionHeadline(headlineSize),
                ),
              ),
              SizedBox(height: isMobile ? 40 : 56),
              if (isMobile)
                Column(
                  children: [
                    for (int i = 0; i < categories.length; i++) ...[
                      if (i > 0) const SizedBox(height: 20),
                      card(i, 0),
                    ],
                  ],
                )
              else
                Column(
                  children: [
                    row(0, 1, 3, 2),
                    const SizedBox(height: 20),
                    row(2, 3, 3, 2),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
