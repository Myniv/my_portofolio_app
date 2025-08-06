import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const CustomAppbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final List<String> _titles = ["Home", "Profile", "About"];
    return AppBar(
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text(_titles[currentIndex], style: TextStyle(color: Colors.white)),
      // leading: IconButton(
      //   icon: Icon(Icons.arrow_back, color: Colors.white),
      //   onPressed: () {},
      // ),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.edit, color: Colors.white),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
