class Project {
  final String imagePath;
  final String title;
  final String subtitle;
  final String? description;
  final List<String>? technologies;

  Project({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.description,
    this.technologies,
  });
}
