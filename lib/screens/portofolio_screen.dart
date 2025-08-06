import 'package:flutter/material.dart';
import 'package:my_portofolio_app/models/project.dart';
import 'package:my_portofolio_app/models/certification.dart';

class PortofolioScreen extends StatelessWidget {
  final List<Project> projectItems = [
    Project(
      imagePath: "assets/images/logo/dotnet.png",
      title: "Backend",
      subtitle: "Asri Company",
    ),
    Project(
      imagePath: "assets/images/logo/dotnet.png",
      title: "Backend",
      subtitle: "LMS",
    ),
    Project(
      imagePath: "assets/images/logo/reactjs.png",
      title: "Frontend",
      subtitle: "Asri Company",
    ),
    Project(
      imagePath: "assets/images/logo/reactjs.png",
      title: "Frontend",
      subtitle: "LMS",
    ),
    Project(
      imagePath: "assets/images/logo/laravel.png",
      title: "Fullstack",
      subtitle: "Health Care",
    ),
    Project(
      imagePath: "assets/images/logo/laravel.png",
      title: "Fullstack",
      subtitle: "E-Commerce",
    ),
    Project(
      imagePath: "assets/images/logo/laravel.png",
      title: "Fullstack",
      subtitle: "LMS",
    ),
  ];

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
    return ListView(
      children: [
        ExpansionTile(
          title: Text(
            "Project",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "This is the project",
            style: TextStyle(color: Colors.grey),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: projectItems.length,
                itemBuilder: (context, index) {
                  final proj = projectItems[index];
                  return _projectCard(
                    proj.imagePath,
                    proj.title,
                    proj.subtitle,
                  );
                },
              ),
            ),
          ],
        ),
        ExpansionTile(
          title: Text(
            "Sertification",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "This is the sertification",
            style: TextStyle(color: Colors.grey),
          ),
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

  Widget _projectCard(String imagePath, String title, String subtitle) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              child: Container(
                color: const Color.fromARGB(136, 0, 0, 0),
                padding: const EdgeInsets.all(3),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                color: const Color.fromARGB(136, 0, 0, 0),
                padding: const EdgeInsets.all(3),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
