import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const CustomAppbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final List<String> titles = ["Home", "Profile", "About"];
    return AppBar(
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text(titles[currentIndex], style: TextStyle(color: Colors.white)),
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
