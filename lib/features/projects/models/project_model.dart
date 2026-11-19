class Project {
  const Project({
    required this.title,
    required this.tagline,
    required this.category,
    required this.description,
    required this.features,
    required this.technologies,
    required this.logoAsset,
    required this.logoFallback,
    required this.videoAsset,
    this.role,
    this.githubUrl,
  });

  final String title;
  final String tagline;
  final String category;
  final String description;
  final List<String> features;
  final List<String> technologies;
  final String logoAsset;
  final String logoFallback;
  final String videoAsset;
  final String? role;
  final String? githubUrl;
}
