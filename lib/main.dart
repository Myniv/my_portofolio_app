import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/auth_provider.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/providers/project_provider.dart';
import 'package:my_portofolio_app/routes.dart';
import 'package:my_portofolio_app/screens/auth_wrapper.dart';
import 'package:my_portofolio_app/screens/dashboard_screen.dart';
import 'package:my_portofolio_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:my_portofolio_app/screens/portofolio_screen.dart';
import 'package:my_portofolio_app/screens/home_screen.dart';
import 'package:my_portofolio_app/widgets/bottom_navbar.dart';
import 'package:my_portofolio_app/widgets/custom_appbar.dart';
import 'package:my_portofolio_app/screens/profile_screen.dart';
import 'package:my_portofolio_app/widgets/custom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      projectId: 't-monument-471602-f3', // Project ID
      messagingSenderId: '52876912540', //Project Number
      apiKey: 'AIzaSyA0caQgVprDqjAt6dplQSxb_xAR54KWmzg', //Web API Key
      appId: '1:52876912540:android:60d51f7be16e9547b2ca59',
    ), // App ID
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      onGenerateRoute: AppRoutes.generateRoute,
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

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    final List<Widget> _screens = [
      profileProvider.profile?.role == "admin"
          ? DashboardScreen()
          : HomeScreen(),
      ProfileScreen(),
      PortofolioScreen(),
    ];
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
        // onSelect: _changeTab,
        // title: _titleScreen,
        // icon: _iconScreen,
      ),
    );
  }
}
