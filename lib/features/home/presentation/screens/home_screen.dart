import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../about/presentation/widgets/about_section.dart';
import '../../../contact/presentation/screens/contact_section.dart';
import '../../../projects/presentation/screens/projects_section.dart';
import '../../../skills/presentation/screens/skills_section.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/hero_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0;
  int _homeVisitCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveIndex);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_updateActiveIndex)
      ..dispose();
    super.dispose();
  }

  void _updateActiveIndex() {
    if (!_scrollController.hasClients) return;

    var activeIndex = 0;
    for (final (key, index) in [
      (_aboutKey, 1),
      (_skillsKey, 2),
      (_projectsKey, 3),
      (_contactKey, 4),
    ]) {
      final sectionContext = key.currentContext;
      final renderObject = sectionContext?.findRenderObject();
      if (renderObject is RenderBox &&
          renderObject.hasSize &&
          renderObject.localToGlobal(Offset.zero).dy <= 120) {
        activeIndex = index;
      }
    }

    if (activeIndex != _activeIndex) {
      setState(() => _activeIndex = activeIndex);
    }
  }

  void _scrollToAbout() {
    _scrollToSection(_aboutKey);
  }

  void _scrollToSkills() {
    _scrollToSection(_skillsKey);
  }

  void _scrollToProjects() {
    _scrollToSection(_projectsKey);
  }

  void _scrollToContact() {
    _scrollToSection(_contactKey);
  }

  void _scrollToSection(GlobalKey key) {
    final sectionContext = key.currentContext;
    if (sectionContext == null) return;

    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToHome() {
    if (!_scrollController.hasClients) return;

    setState(() => _homeVisitCount++);
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: context.palette.background,
      drawer: DrawerMenu(
        activeIndex: _activeIndex,
        onHomeTap: _scrollToHome,
        onAboutTap: _scrollToAbout,
        onSkillsTap: _scrollToSkills,
        onProjectsTap: _scrollToProjects,
        onContactTap: _scrollToContact,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight,
                        child: HeroSection(
                          key: ValueKey(_homeVisitCount),
                          onContactTap: _scrollToContact,
                        ),
                    ),
                    AboutSection(key: _aboutKey),
                    SkillsSection(key: _skillsKey),
                    ProjectsSection(key: _projectsKey),
                    ContactSection(key: _contactKey),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) => Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(-20 * (1 - value), 0),
                    child: child,
                  ),
                ),
                child: _MenuButton(
                  onTap: () => _scaffoldKey.currentState?.openDrawer(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.onTap});

  final VoidCallback onTap;

  Widget _line(BuildContext context, double width) => Container(
    width: width,
    height: 2.5,
    decoration: BoxDecoration(
      color: context.palette.textPrimary,
      borderRadius: BorderRadius.circular(2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _line(context, 24),
              const SizedBox(height: 6),
              _line(context, 16),
              const SizedBox(height: 6),
              _line(context, 24),
            ],
          ),
        ),
      ),
    );
  }
}
