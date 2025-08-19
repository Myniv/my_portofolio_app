import 'package:flutter/material.dart';
import 'package:my_portofolio_app/models/project.dart';
import 'package:my_portofolio_app/models/certification.dart';

class PortofolioScreen extends StatelessWidget {
  final List<Project> projectItems = [
    Project(
      imagePath: "assets/images/logo/dotnet.png",
      title: "Backend",
      subtitle: "Asri Company",
      description:
          "Developed robust backend APIs and services for Asri Company's enterprise management system, handling complex business logic and data processing.",
      technologies: [
        ".NET Core",
        "C#",
        "SQL Server",
        "Entity Framework",
        "REST API",
      ],
    ),
    Project(
      imagePath: "assets/images/logo/dotnet.png",
      title: "Backend",
      subtitle: "LMS",
      description:
          "Built a comprehensive Learning Management System backend with user authentication, course management, and progress tracking capabilities.",
      technologies: [".NET Core", "C#", "PostgreSQL", "JWT", "SignalR"],
    ),
    Project(
      imagePath: "assets/images/logo/reactjs.png",
      title: "Frontend",
      subtitle: "Asri Company",
      description:
          "Created responsive and intuitive user interfaces for Asri Company's web application with modern design principles and optimal user experience.",
      technologies: ["React.js", "JavaScript", "CSS3", "Material-UI", "Redux"],
    ),
    Project(
      imagePath: "assets/images/logo/reactjs.png",
      title: "Frontend",
      subtitle: "LMS",
      description:
          "Developed an interactive learning platform frontend with real-time features, course navigation, and student progress visualization.",
      technologies: [
        "React.js",
        "TypeScript",
        "Tailwind CSS",
        "Axios",
        "Socket.io",
      ],
    ),
    Project(
      imagePath: "assets/images/logo/laravel.png",
      title: "Fullstack",
      subtitle: "Health Care",
      description:
          "Complete healthcare management system with patient records, appointment scheduling, and medical history tracking for healthcare providers.",
      technologies: ["Laravel", "PHP", "MySQL", "Bootstrap", "jQuery"],
    ),
    Project(
      imagePath: "assets/images/logo/laravel.png",
      title: "Fullstack",
      subtitle: "E-Commerce",
      description:
          "Full-featured e-commerce platform with product catalog, shopping cart, payment integration, and order management system.",
      technologies: ["Laravel", "PHP", "MySQL", "Vue.js", "Stripe API"],
    ),
    Project(
      imagePath: "assets/images/logo/laravel.png",
      title: "Fullstack",
      subtitle: "LMS",
      description:
          "End-to-end Learning Management System with course creation, student enrollment, quiz system, and performance analytics.",
      technologies: ["Laravel", "PHP", "MySQL", "Blade", "Chart.js"],
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
          initiallyExpanded: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
                    proj.description ?? "",
                    proj.technologies ?? [],
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

  Widget _projectCard(
    String imagePath,
    String title,
    String subtitle,
    String description,
    List<String> technologies,
  ) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
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
