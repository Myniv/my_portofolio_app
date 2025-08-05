import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

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
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove shadow
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.blueGrey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
