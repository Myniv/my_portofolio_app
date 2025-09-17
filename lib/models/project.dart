class Project {
  int? id;
  String title;
  String? category;
  DateTime? completion_date;
  String description;
  String? image_path;
  String? project_url;
  String? user_id;
  // List<String>? technologies;

  Project({
    this.id,
    this.title = '',
    this.category,
    this.completion_date,
    this.description = '',
    this.image_path,
    this.project_url,
    this.user_id,
    // this.technologies,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json["id"],
    title: json["title"] ?? '',
    category: json["category"],
    completion_date: json["completion_date"] != null
        ? DateTime.parse(json["completion_date"])
        : null,
    description: json["description"] ?? '',
    image_path: json["image_path"],
    project_url: json["project_url"],
    user_id: json["user_id"],
    // technologies: json["technologies"] != null
    //     ? List<String>.from(json["technologies"].map((x) => x))
    //     : null,
  );

  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    "title": title,
    "category": category,
    "completion_date": completion_date?.toIso8601String(),
    "description": description,
    "image_path": image_path,
    "project_url": project_url,
    "user_id": user_id,
    // "technologies": technologies != null ? List<dynamic>.from(technologies!.map((x) => x)) : null,
  };
}
