import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_portofolio_app/screens/about_screen.dart';
import 'package:my_portofolio_app/screens/add_project_screen.dart';
import 'package:my_portofolio_app/screens/edit_profile_screen.dart';
import 'package:my_portofolio_app/screens/not_found_screen.dart';
import 'package:my_portofolio_app/screens/portofolio_screen.dart';
import 'package:my_portofolio_app/screens/profile_screen.dart';
import 'package:my_portofolio_app/screens/setting_screen.dart';

class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const editProfile = '/editProfile';
  static const portofolio = '/portofolio';
  static const addProject = '/addProject';
  static const setting = '/setting';
  static const about = '/about';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case profile:
        return MaterialPageRoute(
          builder: (_) => ProfilePage(),
          settings: settings,
        );
      // case editProfile: return MaterialPageRoute(builder: (_)=> EditProfileScreen(value: value, title: title, profileField: profileField))
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
      default:
        return MaterialPageRoute(
          builder: (_) => NotFoundScreen(),
          settings: settings,
        );
    }
  }
}
