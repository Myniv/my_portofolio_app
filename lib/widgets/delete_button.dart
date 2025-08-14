import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onTab;
  final String name;
  final Color color;
  const DeleteButton({
    super.key,
    required this.onTab,
    required this.name,
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete, color: color ?? Colors.red),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Delete $name"),
              content: Text("Are you sure want to delete $name?"),
              actions: [
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
                ElevatedButton(
                  onPressed: () {
                    onTab();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$name deleted successfully')),
                    );
                  },
                  child: Text('Delete'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
