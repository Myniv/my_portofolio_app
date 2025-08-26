import 'package:flutter/material.dart';
import 'package:my_portofolio_app/widgets/custom_appbar.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Settings",
        icon: Icons.arrow_back,
        onIconPress: () {
          Navigator.pop(context);
        },
      ),
      body: Center(child: Text("Settings Screen")),
    );
  }
}
