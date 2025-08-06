import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final String title;

  const CustomAppbar({super.key, required this.currentIndex, required this.title});

  @override
  Widget build(BuildContext context) {
    // final List<String> titles = ["Home", "Profile", "Portofolio"];
    return AppBar(
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.white)),
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(Icons.menu, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
