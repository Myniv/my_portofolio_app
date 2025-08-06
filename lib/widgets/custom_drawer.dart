import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) _changeTab;
  final List<String> title;
  final List<IconData> icon;
  const CustomDrawer({
    super.key,
    required dynamic Function(int) onSelect,
    required this.title,
    required this.icon,
  }) : _changeTab = onSelect;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu_open, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    'Drawer Menu',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          for (int i = 0; i < title.length; i++)
            ListTile(
              leading: Icon(icon[i]),
              title: Text(title[i]),
              onTap: () {
                _changeTab(i);
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
