import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final String name;

  const EditProfileScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Edit Profile Screen $name', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back To Profile Screen"),
          ),
        ],
      ),
    );
  }
}
