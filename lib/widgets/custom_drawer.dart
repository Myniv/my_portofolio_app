import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) _changeTab;
  const CustomDrawer({super.key, required dynamic Function(int) onSelect})
    : _changeTab = onSelect;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Text('Drawer Menu', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              _changeTab(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              _changeTab(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              _changeTab(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
