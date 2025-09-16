import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_portofolio_app/screens/about_screen.dart';
import 'package:my_portofolio_app/screens/add_project_screen.dart';
import 'package:my_portofolio_app/screens/custom_splash_screen.dart';
import 'package:my_portofolio_app/screens/edit_profile_screen.dart';
import 'package:my_portofolio_app/screens/home_screen.dart';
import 'package:my_portofolio_app/screens/login_screen.dart';
import 'package:my_portofolio_app/screens/not_found_screen.dart';
import 'package:my_portofolio_app/screens/portofolio_screen.dart';
import 'package:my_portofolio_app/screens/profile_screen.dart';
import 'package:my_portofolio_app/screens/register_screen.dart';
import 'package:my_portofolio_app/screens/setting_screen.dart';

class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const editProfile = '/editProfile';
  static const portofolio = '/portofolio';
  static const addProject = '/addProject';
  static const setting = '/setting';
  static const about = '/about';
  static const register = '/register';
  static const login = '/login';
  static const splash = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
          settings: settings,
        );
      case editProfile:
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(),
          settings: settings,
        );
      case portofolio:
        return MaterialPageRoute(
          builder: (_) => PortofolioScreen(),
          settings: settings,
        );
      case addProject:
        return MaterialPageRoute(
          builder: (_) => AddProjectScreen(),
          settings: settings,
        );
      case setting:
        return MaterialPageRoute(
          builder: (_) => SettingScreen(),
          settings: settings,
        );
      case about:
        return MaterialPageRoute(
          builder: (_) => AboutScreen(),
          settings: settings,
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case splash:
        return MaterialPageRoute(
          builder: (_) => CustomSplashScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => NotFoundScreen(),
          settings: settings,
        );
    }
  }
}
