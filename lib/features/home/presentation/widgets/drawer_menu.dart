import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({
    super.key,
    this.activeIndex = 0,
    this.onHomeTap,
    this.onAboutTap,
    this.onSkillsTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  final int activeIndex;
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onSkillsTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _reveal({
    required double start,
    required double end,
    required Widget child,
  }) {
    final anim = _controller.drive(
      CurveTween(curve: Interval(start, end, curve: Curves.easeOutCubic)),
    );
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: anim.drive(
          Tween(begin: const Offset(-0.35, 0), end: Offset.zero),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final items = [
      context.tr('Accueil', 'Home'),
      context.tr('À propos', 'About'),
      context.tr('Compétences', 'Skills'),
      context.tr('Projets', 'Projects'),
      context.tr('Contact', 'Contact'),
    ];
    final width = Responsive.isMobile(context)
        ? MediaQuery.sizeOf(context).width * 0.78
        : 340.0;

    return Drawer(
      width: width,
      backgroundColor: p.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(28)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 24, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _reveal(
                start: 0.0,
                end: 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _LanguageButton(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: p.textPrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              for (int i = 0; i < items.length; i++)
                _reveal(
                  start: 0.15 + i * 0.1,
                  end: 0.55 + i * 0.1,
                  child: _MenuItem(
                    number: '0${i + 1}',
                    label: items[i],
                    active: i == widget.activeIndex,
                    onTap: () {
                      Navigator.pop(context);
                      if (i == 0) widget.onHomeTap?.call();
                      if (i == 1) widget.onAboutTap?.call();
                      if (i == 2) widget.onSkillsTap?.call();
                      if (i == 3) widget.onProjectsTap?.call();
                      if (i == 4) widget.onContactTap?.call();
                    },
                  ),
                ),
              const Spacer(),
              _reveal(
                start: 0.6,
                end: 0.95,
                child: const _ThemeToggle(),
              ),
              const SizedBox(height: 20),
              _reveal(
                start: 0.7,
                end: 1.0,
                child: Text(
                  '© 2026 Fanoela Rakotomalala',
                  style: context.text.menuNumber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    final settings = context.settings;
    final p = context.palette;

    return PopupMenuButton<AppLanguage>(
      tooltip: context.tr('Changer la langue', 'Change language'),
      offset: const Offset(0, 54),
      color: p.surfaceAlt,
      onSelected: settings.setLanguage,
      itemBuilder: (context) => [
        _languageItem(context, AppLanguage.fr, 'FR', 'Français'),
        _languageItem(context, AppLanguage.en, 'EN', 'English'),
      ],
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.accent,
          shape: BoxShape.circle,
        ),
        child: Text(
          settings.isFr ? 'FR' : 'EN',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<AppLanguage> _languageItem(
    BuildContext context,
    AppLanguage language,
    String code,
    String label,
  ) {
    final selected = context.settings.language == language;
    return PopupMenuItem<AppLanguage>(
      value: language,
      child: Row(
        children: [
          Text(code, style: context.text.tag),
          const SizedBox(width: 14),
          Text(label, style: context.text.chip),
          const SizedBox(width: 16),
          if (selected)
            const Icon(Icons.check_rounded, color: AppColors.accent, size: 18),
        ],
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final settings = context.settings;
    final p = context.palette;
    final isDark = settings.isDark;

    Widget segment(ThemeMode mode, IconData icon, String label, bool selected) {
      final color = selected ? Colors.white : p.textSecondary;
      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => settings.setThemeMode(mode),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: context.text.chip.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: p.surfaceAlt,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: p.border),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            alignment: isDark ? Alignment.centerLeft : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              heightFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
            ),
          ),
          Row(
            children: [
              segment(
                ThemeMode.dark,
                Icons.dark_mode_outlined,
                context.tr('Sombre', 'Dark'),
                isDark,
              ),
              segment(
                ThemeMode.light,
                Icons.light_mode_outlined,
                context.tr('Clair', 'Light'),
                !isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.number,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String number;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: Text(number, style: context.text.menuNumber),
            ),
            Expanded(
              child: Text(
                label,
                style: context.text.menuItem.copyWith(
                  color: active ? AppColors.accent : context.palette.textPrimary,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: active ? 24 : 0,
              height: 2,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}
