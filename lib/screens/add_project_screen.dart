import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/project_provider.dart';
import 'package:my_portofolio_app/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  bool _initialized = false;

  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final projectIndex = args?['index'] as int?;
      final selectedCategory = args?['category'] as String?;

      final projectProvider = context.read<ProjectProvider>();

      if (projectIndex != null) {
        projectProvider.getEditProject(projectIndex);
      } else {
        projectProvider.resetProject();
        if (selectedCategory != null) {
          projectProvider.setCategory(selectedCategory);
        }
      }

      _initialized = true;
    }
  }

  final categories = [
    'Web Development',
    'Mobile Development',
    'Data Science',
    'UI/UX Design',
  ];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final projectIndex = args?['index'] as int?;
    final selectedCategory = args?['category'] as String?;
    print("SelectedCategory? $selectedCategory");
    print("ProjectIndex? $projectIndex");

    final projectProvider = Provider.of<ProjectProvider>(context);

    final isEdit = projectIndex != null;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppbar(
        title: "Add Project",
        icon: Icons.arrow_back,
        onIconPress: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: projectProvider.projectKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEdit ? "Edit Project" : "Add New Project",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   "Please enter the new details below.",
                  //   style: TextStyle(color: Colors.grey[600]),
                  // ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: projectProvider.titleController,
                    decoration: InputDecoration(
                      labelText: 'Project Title',
                      hintText: 'Enter project title',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a project title';
                      }

                      if (value.length < 3) {
                        return 'Title must be at least 3 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  DropdownButtonFormField(
                    value: projectProvider.projectData.category,
                    decoration: InputDecoration(
                      labelText: "Category",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: categories
                        .map(
                          (item) =>
                              DropdownMenuItem(value: item, child: Text(item)),
                        )
                        .toList(),
                    onChanged: projectProvider.setCategory,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select Completion Date"),
                          if (projectProvider.projectData.completion_date !=
                              null)
                            Text(
                              'Selected Date: ${DateFormat('yyyy-MM-dd').format(projectProvider.projectData.completion_date!)}',
                            ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => projectProvider.pickDate(context),
                        child: Text(
                          'Select Date',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: projectProvider.descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Project Description',
                      hintText: 'Enter project description',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a project description';
                      }

                      if (value.length < 10) {
                        return 'Description must be at least 10 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Expanded(
                  //           child: TextFormField(
                  //             controller: projectProvider.technologyController,
                  //             decoration: InputDecoration(
                  //               labelText: 'Add Technology',
                  //               hintText: 'Flutter, Laravel, etc',
                  //               filled: true,
                  //               fillColor: Colors.white,
                  //               border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(12),
                  //                 borderSide: BorderSide.none,
                  //               ),
                  //             ),
                  //             onFieldSubmitted: (value) {
                  //               if (value.isNotEmpty) {
                  //                 projectProvider.addTechnology(value);
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //         SizedBox(width: 10),
                  //         ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.blueAccent,
                  //             padding: const EdgeInsets.symmetric(
                  //               vertical: 16,
                  //               horizontal: 20,
                  //             ),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(12),
                  //             ),
                  //           ),
                  //           onPressed: () {
                  //             if (projectProvider
                  //                 .technologyController
                  //                 .text
                  //                 .isNotEmpty) {
                  //               projectProvider.addTechnology(
                  //                 projectProvider.technologyController.text,
                  //               );
                  //             }
                  //           },
                  //           child: Text(
                  //             'Add',
                  //             style: TextStyle(
                  //               // fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(height: 10),
                  //     if (projectProvider.projectData.technologies != null &&
                  //         projectProvider
                  //             .projectData
                  //             .technologies!
                  //             .isNotEmpty) ...[
                  //       Text(
                  //         'Technologies:',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //       SizedBox(height: 8),
                  //       Wrap(
                  //         spacing: 8,
                  //         runSpacing: 8,
                  //         children: projectProvider.projectData.technologies!
                  //             .map((tech) {
                  //               return Chip(
                  //                 label: Text(tech),
                  //                 backgroundColor: Colors.blue[100],
                  //                 deleteIcon: Icon(Icons.close, size: 18),
                  //                 onDeleted: () {
                  //                   projectProvider.removeTechnology(tech);
                  //                 },
                  //               );
                  //             })
                  //             .toList(),
                  //       ),
                  //     ],
                  //   ],
                  // ),
                  SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(child: Text("Select Image")),
                      ElevatedButton(
                        onPressed: () => projectProvider.pickImage(),
                        child: Text(
                          "Choose Image",
                          style: TextStyle(
                            // fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (projectProvider.projectData.image_path != null)
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(projectProvider.projectData.image_path!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(height: 20),

                  TextFormField(
                    controller: projectProvider.linkController,
                    decoration: InputDecoration(
                      labelText: 'Project Link (Optional)',
                      hintText: 'Enter project link (optional)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.refresh,
                          size: 20,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text("Reset Form?"),
                                content: Text(
                                  "Are you sure want to reset the form?",
                                ),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () => Navigator.of(ctx).pop(),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      isEdit
                                          ? projectProvider.getEditProject(
                                              projectIndex,
                                            )
                                          : projectProvider.resetProject();
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('Reset'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        label: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        icon: Icon(Icons.save, size: 20, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: projectProvider.isLoading
                            ? null
                            : () {
                                if (projectProvider.validateProject()) {
                                  projectProvider.saveProject();

                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isEdit
                                              ? 'Project updated successfully!'
                                              : 'Project added successfully!',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  });
                                }
                              },
                        label: projectProvider.isLoading
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                isEdit ? 'Update' : 'Submit',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
