import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<String> title;
  final List<IconData> icon;

  const CustomBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Center(
            child: Text(
              'Portofolio App v1.0',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.1),
            // border: Border(top: BorderSide(color: Colors.purpleAccent, width: 2)),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove shadow
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.blueGrey,
            items: <BottomNavigationBarItem>[
              for (int i = 0; i < title.length; i++)
                BottomNavigationBarItem(icon: Icon(icon[i]), label: title[i]),
            ],
          ),
        ),
      ],
    );
  }
}
