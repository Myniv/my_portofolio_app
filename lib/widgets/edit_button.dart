import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTab;
  final Color? color;

  const EditButton({Key? key, required this.onTab, this.color})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      icon: Icon(Icons.edit, color: color ?? Colors.blueAccent),
      onPressed: () {
        onTab();
      },
    );
  }
}
