import 'package:flutter/material.dart';
import '../models/skill_model.dart';

List<SkillCategory> buildSkillCategories(bool isFr) {
  String t(String fr, String en) => isFr ? fr : en;

  return [
    SkillCategory(
      icon: Icons.devices_rounded,
      title: t(
        'Développement Mobile & Desktop',
        'Mobile & Desktop Development',
      ),
      badge: t('Cœur de métier', 'Core expertise'),
      groups: [
        SkillGroup(
          items: [
            SkillItem(
              'Flutter & Dart',
              logoAssets: const ['assets/logo/flutter.png'],
              detail: t(
                'Architecture modulaire, UI responsive, gestion d’état',
                'Modular architecture, responsive UI, state management',
              ),
            ),
            SkillItem(
              'Python (CustomTkinter)',
              logoAssets: const ['assets/logo/python.png'],
              detail: t(
                'Applications desktop autonomes',
                'Standalone desktop applications',
              ),
            ),
            SkillItem(
              'Java & C#',
              logoAssets: const ['assets/logo/java.png', 'assets/logo/C#.png'],
              detail: t(
                'Bases solides en programmation orientée objet',
                'Solid foundations in object-oriented programming',
              ),
            ),
          ],
        ),
      ],
    ),
    SkillCategory(
      icon: Icons.psychology_outlined,
      title: t(
        'Intelligence Artificielle & Données',
        'Artificial Intelligence & Data',
      ),
      badge: t('Ma valeur ajoutée', 'My added value'),
      groups: [
        SkillGroup(
          items: [
            SkillItem(
              'Google ML Kit',
              logoAssets: const ['assets/logo/MLKit.png'],
              detail: t(
                'Détection de pose, vision mobile',
                'Pose detection, mobile vision',
              ),
            ),
          ],
        ),
        SkillGroup(
          label: t('Notions ML / DL', 'ML / DL basics'),
          items: const [SkillItem('Scikit-Learn'), SkillItem('PyTorch')],
        ),
      ],
    ),
    SkillCategory(
      icon: Icons.dns_outlined,
      title: t('Backend, Web & Bases de données', 'Backend, Web & Databases'),
      groups: [
        SkillGroup(
          label: 'APIs & Web',
          items: [
            SkillItem(
              'Python · Flask',
              logoAssets: const ['assets/logo/python.png'],
            ),
            const SkillItem('FastAPI'),
            SkillItem(
              'PHP · CodeIgniter',
              logoAssets: const ['assets/logo/Codeigniter.png'],
            ),
            SkillItem('React', logoAssets: const ['assets/logo/react.png']),
            SkillItem('Angular', logoAssets: const ['assets/logo/angular.png']),
          ],
        ),
        SkillGroup(
          label: t('Bases de données & Cloud', 'Databases & Cloud'),
          items: [
            SkillItem('SQLite', logoAssets: const ['assets/logo/SQLite.png']),
            SkillItem('MySQL', logoAssets: const ['assets/logo/mySQL.png']),
            SkillItem(
              'Firebase',
              logoAssets: const ['assets/logo/firebase.png'],
            ),
          ],
        ),
      ],
    ),
    SkillCategory(
      icon: Icons.build_outlined,
      title: t('Outils & Environnement', 'Tools & Environment'),
      groups: [
        SkillGroup(
          label: 'Versioning',
          items: [
            SkillItem('Git', logoAssets: const ['assets/logo/git.png']),
            SkillItem('GitHub', logoAssets: const ['assets/logo/github.png']),
          ],
        ),
        SkillGroup(
          label: t('Design & Prototypage', 'Design & Prototyping'),
          items: [
            SkillItem(
              'Google Stitch',
              logoAssets: const ['assets/logo/stitch.png'],
            ),
          ],
        ),
      ],
    ),
  ];
}
