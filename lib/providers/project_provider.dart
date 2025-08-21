import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_portofolio_app/models/project.dart';
import 'package:image_picker/image_picker.dart';

class ProjectProvider with ChangeNotifier {
  final projectKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final technologyController = TextEditingController();

  final List<Project> _projects = [];
  List<Project> get projects => _projects;

  Project projectData = Project();
  final picker = ImagePicker();

  int? _projectIndex;
  int? get projectIndex => _projectIndex;

  bool isLoading = false;

  void setCompletionDate(DateTime? value) {
    projectData.completionDate = value;
    notifyListeners();
  }

  void setCategory(String? value) {
    projectData.category = value!;
    notifyListeners();
  }

  void setImage(String? value) {
    projectData.imagePath = value;
    notifyListeners();
  }

  void addTechnology(String technology) {
    final tech = technology.trim();
    if (tech.isNotEmpty) {
      if (projectData.technologies == null) {
        projectData.technologies = [];
      }

      projectData.technologies!.add(tech);
      technologyController.clear();
      notifyListeners();
    }
  }

  void removeTechnology(String technology) {
    if (projectData.technologies != null) {
      projectData.technologies!.remove(technology);
      notifyListeners();
    }
  }

  void clearTechnologies() {
    if (projectData.technologies != null) {
      projectData.technologies!.clear();
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      projectData.imagePath = pickedFile.path;
      notifyListeners();
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: projectData.completionDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setCompletionDate(picked);
    }
  }

  bool validateProject() {
    return projectKey.currentState!.validate();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void getEditProject(int index) {
    final project = _projects[index];
    _projectIndex = index;

    titleController.text = project.title;
    descriptionController.text = project.description;
    linkController.text = project.link ?? "";
    technologyController.clear();

    projectData = Project(
      title: project.title,
      description: project.description,
      link: project.link,
      category: project.category,
      completionDate: project.completionDate,
      imagePath: project.imagePath,
      technologies: project.technologies != null
          ? List<String>.from(project.technologies!)
          : null,
    );

    notifyListeners();
  }

  void saveProject() {
    projectData.title = titleController.text;
    projectData.description = descriptionController.text;
    projectData.link = linkController.text.isEmpty ? null : linkController.text;

    if (_projectIndex == null) {
      _projects.add(
        Project(
          title: projectData.title,
          description: projectData.description,
          link: projectData.link,
          category: projectData.category,
          completionDate: projectData.completionDate,
          imagePath: projectData.imagePath,
          technologies: projectData.technologies != null
              ? List<String>.from(projectData.technologies!)
              : null,
        ),
      );
    } else {
      _projects[_projectIndex!] = Project(
        title: projectData.title,
        description: projectData.description,
        link: projectData.link,
        category: projectData.category,
        completionDate: projectData.completionDate,
        imagePath: projectData.imagePath,
        technologies: projectData.technologies != null
            ? List<String>.from(projectData.technologies!)
            : null,
      );
    }
    notifyListeners();
    resetProject();
  }

  void resetProject() {
    titleController.clear();
    descriptionController.clear();
    linkController.clear();
    technologyController.clear();
    _projectIndex = null;
    projectData = Project();
    notifyListeners();
  }

  void deleteProject(int index) {
    _projects.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
    technologyController.dispose();
    super.dispose();
  }
}
