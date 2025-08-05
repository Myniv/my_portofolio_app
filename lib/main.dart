import 'package:flutter/material.dart';
import 'package:my_portofolio_app/widgets/bottom_navbar.dart';
import 'package:my_portofolio_app/widgets/custom_appbar.dart';
import 'package:my_portofolio_app/screens/profile_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppbar(),
        body: ProfilePage(),
        bottomNavigationBar: CustomBottomNavbar(),
      ),
    );
  }
}
