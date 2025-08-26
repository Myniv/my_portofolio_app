import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_portofolio_app/screens/add_project_screen.dart';
import 'package:my_portofolio_app/screens/tabs/project_tabs.dart';
import 'package:provider/provider.dart';
import 'package:my_portofolio_app/models/project.dart';
import 'package:my_portofolio_app/models/certification.dart';
import 'package:my_portofolio_app/providers/project_provider.dart';

class PortofolioScreen extends StatelessWidget {
  final List<Certification> certifications = [
    Certification(
      imagePath: "assets/images/logo/solecode.png",
      title: 'Full Stack Web Development',
      subtitle: 'Certified Codeigniter Developer - 2024',
    ),
    Certification(
      imagePath: "assets/images/logo/solecode.png",
      title: 'Frontend Development',
      subtitle: 'Responsive Web Design - 2025',
    ),
    Certification(
      imagePath: "assets/images/logo/solecode.png",
      title: 'Data Analysis',
      subtitle: 'Data Analysis - Solecode Academy - 2026',
    ),
    Certification(
      imagePath: "assets/images/logo/dicoding.png",
      title: 'Android Development',
      subtitle: 'Android Development - Dicoding',
    ),
    Certification(
      imagePath: "assets/images/logo/dicoding.png",
      title: 'Git & GitHub',
      subtitle: 'Version Control Essentials - Dicoding',
    ),
    Certification(
      imagePath: "assets/images/logo/dicoding.png",
      title: 'Kotlin for Beginners',
      subtitle: 'Kotlin for Beginners - Dicoding',
    ),
    Certification(
      imagePath: "assets/images/logo/skilvul.png",
      title: 'Unity Game Development',
      subtitle: 'Game Development - Skilvul',
    ),
    Certification(
      imagePath: "assets/images/logo/skilvul.png",
      title: 'Basic C# Programming',
      subtitle: 'Basic C# Programming - Skilvul',
    ),
    Certification(
      imagePath: "assets/images/logo/skilvul.png",
      title: 'Basic Computer Algorithm',
      subtitle: 'Basic Computer Algorithm - JetBrains',
    ),
    Certification(
      imagePath: "assets/images/logo/dicoding.png",
      title: 'Cyber Security',
      subtitle: 'Foundations of Cybersecurity - Dicoding',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          title: null,
          bottom: TabBar(
            indicatorPadding: EdgeInsets.symmetric(vertical: 12),
            tabs: [
              Tab(icon: Icon(Icons.phone_android, size: 28)),
              Tab(icon: Icon(Icons.web, size: 28)),
              Tab(icon: Icon(Icons.design_services, size: 28)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProjectTabs(filter: "Mobile Development"),
            ProjectTabs(filter: "Web Development"),
            ProjectTabs(filter: "UI/UX Design"),
          ],
        ),
      ),
    );
  }

  Widget _certificationTabs() {
    return ListView(
      children: [
        ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Sertification",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.blue),
                onPressed: () {},
              ),
            ],
          ),
          initiallyExpanded: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListView.builder(
                itemCount: certifications.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final cert = certifications[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _certificationCard(
                      cert.imagePath,
                      cert.title,
                      cert.subtitle,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _certificationCard(String imagePath, String title, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {},
    );
  }
}
