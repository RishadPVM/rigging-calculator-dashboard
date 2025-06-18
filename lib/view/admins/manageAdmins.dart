import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leo_rigging_dashboard/view/admins/controller/admin_controller.dart';
import 'package:leo_rigging_dashboard/view/admins/widgets/admin_list.dart';
import 'package:leo_rigging_dashboard/widget/header.dart';

class AdminsPage extends StatelessWidget {
  const AdminsPage({super.key});

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: "Admins"),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton.icon(
                onPressed: () => Get.dialog(CreateAdminDialog()),
                icon: const Icon(Icons.add),
                label: const Text("Create"),
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(child: AdminGridview()),
          ],
        ),
      ),
    );
  }
}

class CreateAdminDialog extends StatefulWidget {
  @override
  _CreateAdminDialogState createState() => _CreateAdminDialogState();
}

class _CreateAdminDialogState extends State<CreateAdminDialog> {
  final _formKey = GlobalKey<FormState>();
  File? profileImage;
  String name = '', email = '', password = '';
  final AdminController controller = Get.find();

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => profileImage = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Admin'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                child:
                    profileImage == null ? const Icon(Icons.camera_alt, size: 40) : null,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onSaved: (v) => name = v!.trim(),
              validator: (v) => v!.isEmpty ? 'Enter name' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              onSaved: (v) => email = v!.trim(),
              validator: (v) =>
                  v!.isEmpty || !v.contains('@') ? 'Valid email required' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onSaved: (v) => password = v!.trim(),
              validator: (v) =>
                  v!.length < 6 ? 'Min 6 characters' : null,
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        Obx(() => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        controller.createAdmin(
                          profileImage: profileImage,
                          name: name,
                          email: email,
                          password: password,
                        );
                      }
                    },
              child: controller.isLoading.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Create'),
            )),
      ],
    );
  }
}
