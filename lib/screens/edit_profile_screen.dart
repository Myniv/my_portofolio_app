import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final String name;

  const EditProfileScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blueAccent, Colors.blueGrey]),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Edit Profile Screen $name', style: TextStyle(fontSize: 24, color: Colors.white)),
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
