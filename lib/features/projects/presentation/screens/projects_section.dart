import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../shared/widgets/accent_text.dart';
import '../../../../shared/widgets/reveal_on_scroll.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../data/projects_data.dart';
import '../widgets/project_card.dart';
import '../widgets/project_detail_dialog.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final device = Responsive.of(context);
    final isMobile = device == DeviceType.mobile;
    final isDesktop = device == DeviceType.desktop;
    final projects = buildProjects(context.isFr);

    final headlineSize = switch (device) {
      DeviceType.mobile => 26.0,
      DeviceType.tablet => 32.0,
      DeviceType.desktop => 38.0,
    };

    Widget card(int index) => RevealOnScroll(
      delay: Duration(milliseconds: 150 * index),
      child: ProjectCard(
        project: projects[index],
        onTap: () => showProjectDetail(context, projects[index]),
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
                  number: '03',
                  title: context.tr('Projets', 'Projects'),
                ),
              ),
              const SizedBox(height: 24),
              RevealOnScroll(
                delay: const Duration(milliseconds: 100),
                child: AccentText(
                  context.tr(
                    'Trois **projets**, une même **exigence**.',
                    'Three **projects**, one shared **standard**.',
                  ),
                  style: context.text.sectionHeadline(headlineSize),
                ),
              ),
              const SizedBox(height: 12),
              RevealOnScroll(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  context.tr(
                    'Touchez un projet pour voir les détails et la démo.',
                    'Select a project to see its details and demo.',
                  ),
                  style: context.text.body,
                ),
              ),
              SizedBox(height: isMobile ? 36 : 52),
              if (isDesktop)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < projects.length; i++) ...[
                        if (i > 0) const SizedBox(width: 24),
                        Expanded(child: card(i)),
                      ],
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    for (int i = 0; i < projects.length; i++) ...[
                      if (i > 0) const SizedBox(height: 20),
                      card(i),
                    ],
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
