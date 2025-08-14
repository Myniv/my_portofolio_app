import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      backgroundColor: Colors.grey[100],
      appBar: CustomAppbar(
        title: "Edit $title",
        icon: Icons.arrow_back,
        onIconPress: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update your $title",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please enter the new details below.",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: value2 != null ? 'Name' : title,
                hintText: value2 != null
                    ? 'Enter your name'
                    : 'Enter your $title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: profileField == ProfileField.phone
                  ? TextInputType.number
                  : profileField == ProfileField.email
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              inputFormatters: profileField == ProfileField.phone
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
            ),
            const SizedBox(height: 20),

            if (value2 != null) ...[
              TextField(
                controller: _controller2,
                decoration: InputDecoration(
                  labelText: 'Profession',
                  hintText: 'Enter your profession',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save, size: 20),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                onPressed: () {
                  final newValue = _controller.text.trim();
                  final newValue2 = value2 != null
                      ? _controller2.text.trim()
                      : null;

                  if (newValue.isNotEmpty) {
                    context.read<ProfileProvider>().addEditProfileField(
                      newValue,
                      newValue2,
                      profileField,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$title edited successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                label: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
