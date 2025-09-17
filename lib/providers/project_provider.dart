import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_portofolio_app/models/project.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/services/project_service.dart';

class ProjectProvider with ChangeNotifier {
  final projectKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final technologyController = TextEditingController();

  List<Project> _projects = [];
  List<Project> get projects => _projects;

  Project projectData = Project();
  final picker = ImagePicker();

  int? _projectIndex;
  int? get projectIndex => _projectIndex;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final ProjectService _projectService = ProjectService();
  final ProfileProvider profileProvider;

  ProjectProvider(this.profileProvider);

  Future<void> fetchProjects() async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();

    try {
      final role = profileProvider?.profile?.role;
      final uid = profileProvider?.profile?.uid;

      print("ProjectProvider -> role: $role, uid: $uid");
      if (profileProvider.profile!.role == 'member') {
        _projects = await _projectService.getProjectByUserId(
          profileProvider.profile!.uid,
        );
      } else {
        _projects = await _projectService.fetchProjects();
      }
    } catch (e) {
      _errorMessage = "Failed to fetch projects";
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCompletionDate(DateTime? value) {
    projectData.completion_date = value;
    notifyListeners();
  }

  void setCategory(String? value) {
    projectData.category = value!;
    notifyListeners();
  }

  void setImage(String? value) {
    projectData.image_path = value;
    notifyListeners();
  }

  // void addTechnology(String technology) {
  //   final tech = technology.trim();
  //   if (tech.isNotEmpty) {
  //     if (projectData.technologies == null) {
  //       projectData.technologies = [];
  //     }
  //     projectData.technologies!.add(tech);
  //     technologyController.clear();
  //     notifyListeners();
  //   }
  // }

  // void removeTechnology(String technology) {
  //   if (projectData.technologies != null) {
  //     projectData.technologies!.remove(technology);
  //     notifyListeners();
  //   }
  // }

  // void clearTechnologies() {
  //   if (projectData.technologies != null) {
  //     projectData.technologies!.clear();
  //     notifyListeners();
  //   }
  // }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      projectData.image_path = pickedFile.path;
      notifyListeners();
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: projectData.completion_date ?? DateTime.now(),
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

  // void setLoading(bool isLoading) {
  //   this.isLoading = isLoading;
  //   notifyListeners();
  // }

  Future<void> getEditProject(int projectId) async {
    final index = _projects.indexWhere((p) => p.id == projectId);

    if (index != -1) {
      _projectIndex = projectId;
      final project = _projects[index];

      titleController.text = project.title;
      descriptionController.text = project.description;
      linkController.text = project.project_url ?? "";

      projectData = Project(
        id: project.id,
        title: project.title,
        description: project.description,
        project_url: project.project_url,
        category: project.category,
        completion_date: project.completion_date,
        image_path: project.image_path,
        user_id: project.user_id,
      );

      notifyListeners();
    }
  }

  Future<void> saveProject() async {
    _isLoading = true;
    notifyListeners();

    try {
      projectData.user_id = projectData.user_id ?? profileProvider.profile!.uid;
      projectData.title = titleController.text;
      projectData.description = descriptionController.text;
      projectData.project_url = linkController.text.isEmpty
          ? null
          : linkController.text;

      if (_projectIndex == null) {
        final newProject = await _projectService.addProject(projectData);
        _projects.add(newProject);
      } else {
        projectData.id = _projectIndex;
        await _projectService.updateProject(projectData);

        final index = _projects.indexWhere((p) => p.id == _projectIndex);
        if (index != -1) {
          _projects[index] = projectData;
        }
      }

      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      print(_errorMessage);
    } finally {
      _isLoading = false;
      resetProject();
      notifyListeners();
    }
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

  Future<void> deleteProject(int projectId) async {
    try {
      await _projectService.deleteProject(projectId);

      _projects.removeWhere((project) => project.id == projectId);

      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to delete project: $e";
      print(_errorMessage);
      notifyListeners();
      rethrow;
    }
  }
}
