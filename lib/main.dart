import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/providers/project_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_portofolio_app/screens/portofolio_screen.dart';
import 'package:my_portofolio_app/screens/home_screen.dart';
import 'package:my_portofolio_app/widgets/bottom_navbar.dart';
import 'package:my_portofolio_app/widgets/custom_appbar.dart';
import 'package:my_portofolio_app/screens/profile_screen.dart';
import 'package:my_portofolio_app/widgets/custom_drawer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample Portfolio App",
      // home: Scaffold(
      //   appBar: CustomAppbar(),
      //   body: ProfilePage(),
      //   bottomNavigationBar: CustomBottomNavbar(),
      // ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() => _currentIndex = index);
  }

  final List<String> _titleScreen = ["Home", "Profile", "Portofolio"];
  final List<IconData> _iconScreen = [Icons.home, Icons.person, Icons.work];
  final List<Widget> _screens = [
    HomeScreen(),
    ProfilePage(),
    PortofolioScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: _titleScreen[_currentIndex]),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _currentIndex,
        onTap: _changeTab,
        title: _titleScreen,
        icon: _iconScreen,
      ),
      drawer: CustomDrawer(
        onSelect: _changeTab,
        title: _titleScreen,
        icon: _iconScreen,
      ),
    );
  }
}
