import 'package:flutter/material.dart';
import 'package:my_portofolio_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_portofolio_app/widgets/custom_appbar.dart';

class EditProfileScreen extends StatelessWidget {
  final String title;
  final String value;
  final String? value2;
  final ProfileField profileField;

  const EditProfileScreen({
    super.key,
    required this.value,
    this.value2,
    required this.title,
    required this.profileField,
  });

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController(text: value);
    final _controller2 = TextEditingController(text: value2);
    return Scaffold(
      appBar: CustomAppbar(
        title: title,
        icon: Icons.arrow_back,
        onIconPress: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "${title}"),
            ),
            SizedBox(height: 20),
            if (value2 != null) ...[
              TextField(
                controller: _controller2,
                decoration: InputDecoration(labelText: title),
              ),
              SizedBox(height: 20),
            ],

            ElevatedButton(
              onPressed: () {
                final newValue = _controller.text;
                final newValue2 = value2 != null ? _controller2.text : null;
                if (newValue.isNotEmpty) {
                  context.read<ProfileProvider>().addEditProfileField(
                    newValue,
                    newValue2,
                    profileField,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
