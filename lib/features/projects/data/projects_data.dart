import '../models/project_model.dart';

List<Project> buildProjects(bool isFr) {
  String t(String fr, String en) => isFr ? fr : en;

  return [
    Project(
      title: 'AI-Dance-Coach',
      tagline: t(
        'Un coach de danse intelligent dans votre poche.',
        'A smart dance coach in your pocket.',
      ),
      category: t('Stage · Studio MG', 'Internship · Studio MG'),
      description: t(
        'Application Flutter qui compare la performance d’un danseur à une '
            'vidéo de référence, calcule un score et donne des conseils de '
            'correction en français.',
        'Flutter app that compares a dancer’s performance with a reference '
            'video, computes a score and gives correction advice in French.',
      ),
      features: [
        t('Détection de pose avec Google ML Kit', 'Pose detection with Google ML Kit'),
        t(
          'Alignement temporel des mouvements (DTW)',
          'Temporal alignment of movements (DTW)',
        ),
        t(
          'Découpage rythmique en mesures (Librosa)',
          'Rhythmic segmentation into bars (Librosa)',
        ),
        t('Feedback visuel avec squelette', 'Visual feedback with skeleton'),
      ],
      technologies: const [
        'Flutter',
        'Dart',
        'Google ML Kit',
        'DTW',
        'Python',
        'Flask',
        'Librosa',
        'SQLite',
      ],
      logoAsset: 'assets/images/projects/ai_dance_coach.png',
      logoFallback: 'ADC',
      videoAsset: 'assets/videos/ai_dance_coach.MP4',
      role: t(
        'Projet en binôme : j’ai conçu la partie IA (poses, angles, '
            'alignement et score).',
        'Two-person project: I designed the AI part (poses, angles, alignment '
            'and scoring).',
      ),
    ),
    Project(
      title: 'SCAI',
      tagline: t(
        'Le pointage des présences par reconnaissance faciale.',
        'Attendance tracking through face recognition.',
      ),
      category: t('Projet universitaire · ISPM', 'University project · ISPM'),
      description: t(
        'Application de bureau qui enregistre les visages par webcam puis '
            'pointe automatiquement la présence des personnes reconnues.',
        'Desktop application that registers faces through a webcam, then '
            'automatically marks the attendance of recognized people.',
      ),
      features: [
        t('Inscription avec capture du visage', 'Registration with face capture'),
        t(
          'Reconnaissance et pointage automatique',
          'Automatic recognition and attendance marking',
        ),
        t('Historique des présences', 'Attendance history'),
        t(
          'Gestion des profils, données stockées en local',
          'Profile management, data stored locally',
        ),
      ],
      technologies: const [
        'Python',
        'CustomTkinter',
        'OpenCV',
        'Dlib',
        'NumPy',
        'SQLite',
      ],
      logoAsset: 'assets/images/projects/scai.png',
      logoFallback: 'SCAI',
      videoAsset: 'assets/videos/scai.mp4',
    ),
    Project(
      title: 'Madeleine Manager',
      tagline: t(
        'Gérer la production et les ventes de madeleines.',
        'Manage madeleine production and sales.',
      ),
      category: t('Application de gestion · Hors-ligne', 'Management app · Offline'),
      description: t(
        'Application Flutter pour une petite activité artisanale : production, '
            'stocks, ventes, dépenses et trésorerie, sans connexion.',
        'Flutter app for a small craft business: production, stock, sales, '
            'expenses and cash flow, with no internet connection needed.',
      ),
      features: [
        t(
          'Recettes et consommation des matières premières',
          'Recipes and raw material consumption',
        ),
        t(
          'Production avec coûts d’électricité et de lait',
          'Production with electricity and milk costs',
        ),
        t(
          'Ventes, livraisons et suivi des impayés',
          'Sales, deliveries and unpaid tracking',
        ),
        t('Trésorerie et historique complet', 'Cash flow and full history'),
      ],
      technologies: const [
        'Flutter',
        'Dart',
        'SQLite',
        'sqflite',
        'Material 3',
      ],
      logoAsset: 'assets/images/projects/madeleine_manager.png',
      logoFallback: 'MM',
      videoAsset: 'assets/videos/madeleine_manager.mp4',
    ),
  ];
}
