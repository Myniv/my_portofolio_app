import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/project_provider.dart';
import 'package:my_portofolio_app/screens/add_project_screen.dart';
import 'package:provider/provider.dart';

class ProjectTabs extends StatelessWidget {
  final String filter;
  ProjectTabs({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<ProjectProvider>();

    final projectItems = items.projects
        .where((project) => project.category == filter)
        .toList();

    print("Filtered Projects: $projectItems");

    return Scaffold(
      body: projectItems.isEmpty
          ? const Center(child: Text("No projects yet"))
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                    itemCount: projectItems.length,
                    itemBuilder: (context, index) {
                      final proj = projectItems[index];
                      return _projectCard(
                        proj.imagePath ?? "",
                        proj.title,
                        proj.category ?? "",
                        proj.description ?? "",
                        proj.technologies ?? [],
                        context,
                        index,
                      );
                    },
                  ),
                ),
              ],
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/addProject',
            arguments: {'index': null, 'category': filter},
          );
        },
        child: const Icon(Icons.add, color: Colors.blue),
      ),
    );
  }

  Widget _projectCard(
    String imagePath,
    String title,
    String subtitle,
    String description,
    List<String> technologies,
    BuildContext context,
    int index,
  ) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            // Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imagePath.startsWith('assets/')
                          ? AssetImage(imagePath) as ImageProvider
                          : FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (technologies.isNotEmpty) ...[
                          Text(
                            "Technologies:",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 4,
                            runSpacing: 2,
                            children: technologies.take(3).map((tech) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          if (technologies.length > 3)
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                "+${technologies.length - 3} more",
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Floating edit button (top-right)
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => AddProjectScreen(projectIndex: index),
                  //   ),
                  // );
                  Navigator.pushNamed(
                    context,
                    '/addProject',
                    arguments: {'index': index, 'category': null},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
