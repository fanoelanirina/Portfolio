import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/core.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../shared/widgets/accent_text.dart';
import '../../../../shared/widgets/reveal_on_scroll.dart';
import '../../../../shared/widgets/section_title.dart';
import '../../../../shared/widgets/social_icon_button.dart';
import '../widgets/contact_form.dart';
import '../widgets/contact_info_tile.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final device = Responsive.of(context);
    final isMobile = device == DeviceType.mobile;
    final isDesktop = device == DeviceType.desktop;
    final headlineSize = switch (device) {
      DeviceType.mobile => 26.0,
      DeviceType.tablet => 32.0,
      DeviceType.desktop => 38.0,
    };
    final info = _buildInfo(context);
    final form = RevealOnScroll(
      delay: const Duration(milliseconds: 200),
      child: TapRegion(
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        child: const ContactForm(),
      ),
    );

    return Container(
      width: double.infinity,
      color: context.palette.background,
      padding: EdgeInsets.fromLTRB(
        isMobile ? 24 : size.width * 0.08,
        isMobile ? 64 : 100,
        isMobile ? 24 : size.width * 0.08,
        32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, headlineSize),
              SizedBox(height: isMobile ? 36 : 52),
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: info),
                    const SizedBox(width: 64),
                    Expanded(flex: 6, child: form),
                  ],
                )
              else ...[
                info,
                const SizedBox(height: 40),
                form,
              ],
              const SizedBox(height: 64),
              Divider(color: context.palette.border),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  context.tr(
                    '© 2026 Fanoela Rakotomalala · Conçu avec Flutter',
                    '© 2026 Fanoela Rakotomalala · Built with Flutter',
                  ),
                  style: context.text.menuNumber,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double headlineSize) {
    final opportunities = [
      context.tr('Stage', 'Internship'),
      context.tr('CDI', 'Permanent (CDI)'),
      context.tr('CDD', 'Fixed-term (CDD)'),
      'Freelance',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: SectionTitle(number: '04', title: 'Contact'),
        ),
        const SizedBox(height: 24),
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: AccentText(
            context.tr(
              'Travaillons **ensemble**.',
              'Let’s work **together**.',
            ),
            style: context.text.sectionHeadline(headlineSize),
          ),
        ),
        const SizedBox(height: 16),
        RevealOnScroll(
          delay: const Duration(milliseconds: 200),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: AccentText(
              context.tr(
                'Je recherche des opportunités en développement **Flutter**, '
                    'et au besoin en développement logiciel ou web. '
                    'Un projet en tête ? Je suis aussi disponible en freelance.',
                'I’m looking for opportunities in **Flutter** development, '
                    'and if needed in software or web development. '
                    'Got a project in mind? I’m also available for freelance work.',
              ),
              style: context.text.body.copyWith(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var i = 0; i < opportunities.length; i++)
              RevealOnScroll(
                delay: Duration(milliseconds: 300 + 100 * i),
                child: _OpportunityChip(label: opportunities[i]),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RevealOnScroll(
          child: ContactInfoTile(
            icon: Icons.mail_outline,
            label: 'Email',
            value: AppUrls.email,
            copyMessage: context.tr('Email copié !', 'Email copied!'),
          ),
        ),
        const SizedBox(height: 14),
        RevealOnScroll(
          delay: const Duration(milliseconds: 100),
          child: ContactInfoTile(
            icon: Icons.phone_outlined,
            label: context.tr('Téléphone / WhatsApp', 'Phone / WhatsApp'),
            value: AppUrls.phone,
            copyMessage: context.tr('Numéro copié !', 'Number copied!'),
            actionUrl: AppUrls.whatsappUrl,
            actionIcon: const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: AppColors.accent,
              size: 20,
            ),
            actionTooltip: context.tr(
              'Écrire sur WhatsApp',
              'Message on WhatsApp',
            ),
          ),
        ),
        const SizedBox(height: 14),
        RevealOnScroll(
          delay: const Duration(milliseconds: 200),
          child: ContactInfoTile(
            icon: Icons.location_on_outlined,
            label: context.tr('Localisation', 'Location'),
            value: AppUrls.location,
            subtitle: context.tr(
              'Disponible en télétravail / Remote',
              'Available for remote work',
            ),
          ),
        ),
        const SizedBox(height: 32),
        RevealOnScroll(
          delay: const Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr('RETROUVEZ-MOI SUR', 'FIND ME ON'),
                style: context.text.menuNumber,
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SocialIconButton(
                    icon: const FaIcon(FontAwesomeIcons.linkedinIn),
                    label: 'LinkedIn',
                    url: AppUrls.linkedinUrl,
                  ),
                  SocialIconButton(
                    icon: const FaIcon(FontAwesomeIcons.github),
                    label: 'GitHub',
                    url: AppUrls.githubUrl,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OpportunityChip extends StatelessWidget {
  const _OpportunityChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.accent,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(label, style: context.text.chip),
        ],
      ),
    );
  }
}
