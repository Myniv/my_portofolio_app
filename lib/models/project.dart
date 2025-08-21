class Project {
  String title;
  String? category;
  DateTime? completionDate;
  String description;
  String? imagePath;
  String? link;
  List<String>? technologies;

  Project({
    this.title = '',
    this.category,
    this.completionDate,
    this.description = '',
    this.imagePath,
    this.link,
    this.technologies,
  });
}
