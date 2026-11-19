import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../shared/widgets/accent_text.dart';
import '../../../../shared/widgets/reveal_on_scroll.dart';
import '../../../../shared/widgets/section_title.dart';
import 'passions_block.dart';
import 'philosophy_block.dart';
import 'timeline_entry.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final device = Responsive.of(context);
    final isMobile = device == DeviceType.mobile;
    final introSize = switch (device) {
      DeviceType.mobile => 16.0,
      DeviceType.tablet => 18.0,
      DeviceType.desktop => 20.0,
    };

    final header = _buildHeader(context, introSize);
    final journey = _buildJourney(context);
    const passions = PassionsBlock();
    const philosophy = PhilosophyBlock();

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
              header,
              SizedBox(height: isMobile ? 40 : 56),
              if (isMobile) ...[
                journey,
                const SizedBox(height: 48),
                passions,
                const SizedBox(height: 48),
                philosophy,
              ] else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: journey),
                    const SizedBox(width: 64),
                    const Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          passions,
                          SizedBox(height: 56),
                          philosophy,
                        ],
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

  Widget _buildHeader(BuildContext context, double introSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: SectionTitle(
            number: '01',
            title: context.tr('À propos', 'About'),
          ),
        ),
        const SizedBox(height: 24),
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: AccentText(
            context.tr(
              'Jeune diplômé d’une Licence en Informatique de l’ISPM, '
                  'je me spécialise dans le développement mobile avec '
                  '**Flutter**. Doté de notions en Machine Learning, j’ai '
                  'particulièrement exploré l’intégration de **Google ML Kit** '
                  'dans des applications concrètes. Rigoureux, curieux et '
                  'persévérant, j’allie les bases acquises durant mon cursus '
                  'aux outils d’IA modernes pour concevoir des applications '
                  'soignées et performantes.',
              'A recent Computer Science graduate from ISPM, I specialize in '
                  'mobile development with **Flutter**. With a foundation in '
                  'Machine Learning, I have explored integrating **Google ML '
                  'Kit** into practical applications. Rigorous, curious and '
                  'persistent, I combine my academic foundations with modern '
                  'AI tools to build polished, high-performance apps.',
            ),
            style: context.text.sectionHeadline(introSize),
          ),
        ),
      ],
    );
  }

  Widget _buildJourney(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: Text(
            context.tr('Mon parcours', 'My journey'),
            style: context.text.blockTitle,
          ),
        ),
        const SizedBox(height: 24),
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: TimelineEntry(
            logoAsset: 'assets/images/logos/ispm.png',
            logoFallback: 'ISPM',
            title: context.tr(
              'Licence en Informatique',
              'Bachelor’s degree in Computer Science',
            ),
            organization: context.tr(
              'ISPM · Institut Supérieur Polytechnique de Madagascar',
              'ISPM · Higher Polytechnic Institute of Madagascar',
            ),
            description: context.tr(
              'Parcours ESIIA : Électronique, Systèmes Informatiques '
                  'et Intelligence Artificielle.',
              'ESIIA track: Electronics, Computer Systems and Artificial '
                  'Intelligence.',
            ),
            isFirst: true,
          ),
        ),
        RevealOnScroll(
          delay: const Duration(milliseconds: 250),
          child: TimelineEntry(
            logoAsset: 'assets/images/logos/studio_mg.png',
            logoFallback: 'SMG',
            title: context.tr(
              'Stage en développement et IA',
              'Development & AI internship',
            ),
            organization: 'Studio MG',
            description: context.tr(
              'Conception de solutions logicielles et intégration d’IA : '
                  'vision par ordinateur et traitement audio.',
              'Designed software solutions and integrated AI: computer vision '
                  'and audio processing.',
            ),
            isLast: true,
          ),
        ),
      ],
    );
  }
}
