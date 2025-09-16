import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_portofolio_app/screens/custom_splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/auth_provider.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/providers/project_provider.dart';
import 'package:my_portofolio_app/routes.dart';
import 'package:my_portofolio_app/screens/admin/profile_list_screen.dart';
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

  //For using splash screen from pubspec.yaml (not custom splash screen)
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: FirebaseOptions(
      projectId: 't-monument-471602-f3', // Project ID
      messagingSenderId: '52876912540', //Project Number
      apiKey: 'AIzaSyA0caQgVprDqjAt6dplQSxb_xAR54KWmzg', //Web API Key
      appId: '1:52876912540:android:60d51f7be16e9547b2ca59',
    ), // App ID
  );
  await Supabase.initialize(
    url: 'https://ltvskbkhdfgvkveqaxpg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0dnNrYmtoZGZndmt2ZXFheHBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1MjU3NjUsImV4cCI6MjA3MzEwMTc2NX0.i2YH6LvyAwkreZ11f-NbUkQBq7oQ5xuKHqe9sIEWhGE',
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

  //For using splash screen from pubspec.yaml (not custom splash screen)
  // await Future.delayed(const Duration(seconds: 2));
  // FlutterNativeSplash.remove();
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
      initialRoute: AppRoutes.splash,
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

    final List<Widget> _screensAdmin = [
      DashboardScreen(),
      ProfileListScreen(),
      PortofolioScreen(),
    ];

    final List<Widget> _screensMember = [
      HomeScreen(),
      ProfileScreen(),
      PortofolioScreen(),
    ];

    late final List<Widget> _screens = profileProvider.profile?.role == "admin"
        ? _screensAdmin
        : _screensMember;

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
