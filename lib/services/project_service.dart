import 'dart:convert';

import 'package:my_portofolio_app/models/project.dart';
import 'package:http/http.dart' as http;

class ProjectService {
  // static const String baseUrl = "http://localhost:5144/api/projects/";
  static const String baseUrl = "http://10.0.2.2:5144/api/projects/";
  // static const String baseUrl = "http://192.168.1.50:5144/api/projects/";

  Future<List<Project>> fetchProjects() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Project.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (e) {
      print("Error fetching projects: $e");
      return [];
    }
  }

  Future<Project> getProjectById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Project.fromJson(data);
      } else {
        throw Exception('Failed to load project');
      }
    } catch (e) {
      print("Error fetching project by ID: $e");
      rethrow;
    }
  }

  Future<Project> addProject(Project project) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(project.toJson()),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return Project.fromJson(data);
      } else {
        throw Exception('Failed to add project');
      }
    } catch (e) {
      print("Error adding project: $e");
      rethrow;
    }
  }

  Future<void> updateProject(Project project) async {
    try {
      final response = await http.put(
        // Uri.parse('$baseUrl/${project.id}'),
        Uri.parse('$baseUrl${project.id}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(project.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update project');
      }
    } catch (e) {
      print("Error updating project: $e");
    }
  }

  Future<void> deleteProject(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}$id'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
          'Server returned status ${response.statusCode}: ${response.body}',
        );
      }
    } catch (e) {
      rethrow; 
    }
  }
}
