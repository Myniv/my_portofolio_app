import 'package:flutter/material.dart';
import 'package:my_portofolio_app/main.dart';
import 'package:my_portofolio_app/providers/auth_provider.dart';
import 'package:my_portofolio_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.user != null) {
      return const MainScreen();
    } else {
      return const LoginScreen();
    }
  }
}
