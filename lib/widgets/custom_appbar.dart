import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onIconPress;
  final IconData? icon;

  const CustomAppbar({
    super.key,
    required this.title,
    this.onIconPress,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // final List<String> titles = ["Home", "Profile", "Portofolio"];
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text(title, style: TextStyle(color: Colors.white)),
      leading: canPop
          ? IconButton(
              onPressed: onIconPress,
              icon: Icon(icon),
              color: Colors.white,
            )
          : Builder(
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
