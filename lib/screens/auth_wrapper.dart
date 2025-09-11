import 'package:flutter/material.dart';
import 'package:my_portofolio_app/main.dart';
import 'package:my_portofolio_app/providers/auth_provider.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:my_portofolio_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ProfileProvider>(
      builder: (context, authProvider, profileProvider, child) {
        if (!authProvider.isInitialized) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authProvider.user != null) {
          if (profileProvider.profile == null && !profileProvider.isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              profileProvider.loadProfile(authProvider.user!.uid);
            });
          }

          if (profileProvider.profile == null && profileProvider.isLoading) {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading profile...'),
                  ],
                ),
              ),
            );
          }

          if (profileProvider.profile != null) {
            return const MainScreen();
          }

          if (profileProvider.errorMessage != null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 48),
                    SizedBox(height: 16),
                    Text(
                      'Failed to load profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(profileProvider.errorMessage ?? ''),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        profileProvider.loadProfile(authProvider.user!.uid);
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
        }

        return const LoginScreen();
      },
    );
  }
}
